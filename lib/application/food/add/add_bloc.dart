import 'package:bloc/bloc.dart';
import 'package:fitness_tracker/domain/failures/failures.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../../infrastructure/models/food_model.dart';
import '../../../infrastructure/repositories/food_repository_impl.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final _repo = FoodRepositoryImpl();

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  AddBloc() : super(AddInitial()) {
    on<AddRequestRecommendation>((event, emit) {
      emit(AddShowRecommendation());
    });

    on<AddRequested>((event, emit) async {
      // First check cache
      final cacheResult = await _repo.searchInCache(event.searchTerm);
      if (cacheResult.isNotEmpty) {
        emit(AddSuccess(requestedFoods: cacheResult, searchInput: event.searchTerm));
      }
      // Remote API Call
      else {
        await Future.delayed(Duration(seconds: 2));
        emit(AddLoading());
        final remoteResult = await _repo.searchRemote(event.searchTerm);
        remoteResult.when(
              (success) {
            emit(AddSuccess(requestedFoods: success, searchInput: event.searchTerm));
          },
              (error) {
            emit(AddError(failure: error));
          },
        );
        //add(AddRemoteRequested(event.searchTerm));
      }
    }, transformer: restartable());

    on<AddItemSelected>((event, emit) {
      final s = state as AddSuccess;
      emit(AddShowDetails(requestedFoods: s.requestedFoods, index: event.index));
    },);

    on<AddBackToResults>((event, emit) {
      emit(AddSuccess(requestedFoods: (state as AddShowDetails).requestedFoods, searchInput: state.searchInput));
    },);
  }
}
