import 'package:bloc/bloc.dart';
import 'package:fitness_tracker/domain/failures/failures.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../../infrastructure/models/food_model.dart';
import '../../../infrastructure/repositories/food_repository_impl.dart';
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
      final cacheResult = await _repo.searchInCache(event.searchTerm);
      if (cacheResult.isNotEmpty) {
        emit(AddSuccess(requestedFoods: cacheResult));
      } else {
        add(AddRemoteRequested(event.searchTerm));
      }
    });

    on<AddRemoteRequested>((event, emit) async {
      if (state is! AddShowDetails && ) {
        emit(AddLoading());
        final remoteResult = await _repo.searchRemote(event.searchTerm);
        remoteResult.when(
          (success) {
            emit(AddSuccess(requestedFoods: success));
          },
          (error) {
            emit(AddError(failure: error));
          },
        );
      }
    }, transformer: debounce(Duration(seconds: 2)));

    on<AddItemSelected>((event, emit) {
      final s = state as AddSuccess;
      emit(AddShowDetails(requestedFoods: s.requestedFoods, index: event.index));
    },);

    on<AddBackToResults>((event, emit) {
      emit(AddSuccess(requestedFoods: (state as AddShowDetails).requestedFoods));
    },);
  }
}
