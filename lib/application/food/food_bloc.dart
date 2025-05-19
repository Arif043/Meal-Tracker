import 'package:bloc/bloc.dart';
import 'package:fitness_tracker/infrastructure/repositories/food_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import '../../infrastructure/models/consumed_food_model.dart';
import '../../infrastructure/models/food_model.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final _repo = FoodRepositoryImpl();
  bool _cancelRemoteRequest = false;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  FoodBloc() : super(FoodState()) {
    on<FoodLoadEvent>((event, emit) {});

    on<FoodAdd>((event, emit) {
      _repo.saveConsumedFood(event.food);
      emit(
        state.copyWith(
          consumedFoods: [...?state.consumedFoods, event.food],
        ),
      );
    });

    on<FoodAddPressed>((event, emit) {
      _cancelRemoteRequest = false;
      emit(FoodAddState());
    },);

    on<FoodRequested>((event, emit) async {
      final cacheResult = await _repo.searchInCache(event.searchTerm);
      if (cacheResult.isNotEmpty) {
        emit((state as FoodAddState).copyWith(requestedFoods: cacheResult));
      }
      else {
        add(FoodRemoteRequested(event.searchTerm));
      }
    });

    on<FoodRemoteRequested>((event, emit) async {
      final remoteResult = await _repo.searchRemote(event.searchTerm);
      // final cacheResult = await _repo.searchInCache(event.searchTerm);
      // if (cacheResult.isEmpty && !_cancelRemoteRequest) {
      //   final remoteResult = await _repo.searchRemote(event.searchTerm);
      //   remoteResult.when((success) {
      //     emit(state.copyWith(requestedFoods: success));
      //   }, (error) {
      //     debugPrint(error.toString());
      //   },);
      // }
    }, transformer: debounce(Duration(seconds: 2)));

    on<FoodCancelPressed>((event, emit) {
      _cancelRemoteRequest = true;
    },);
  }
}
