import 'package:bloc/bloc.dart';
import 'package:fitness_tracker/infrastructure/repositories/food_repository.dart';
import 'package:meta/meta.dart';

import '../../infrastructure/models/consumed_food_model.dart';
import '../../infrastructure/models/food_model.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final _repo = FoodRepository();

  FoodBloc() : super(FoodState()) {
    on<LoadFoodEvent>((event, emit) {});

    on<AddFoodEvent>((event, emit) {
      _repo.saveConsumedFood(event.food);
      emit(
        state.copyWith(
          consumedFoods: [...?state.consumedFoods, event.food],
          showDialog: false,
        ),
      );
    });

    on<ShowAddDialog>((event, emit) {
      emit(state.copyWith(showDialog: true));
    },);

    on<FoodRequestedEvent>((event, emit) async {
      final result = await _repo.search(event.searchTerm);
      result.when(
              (success) {
                emit(state.copyWith(requestedFoods: success));
              },
              (error) {});
    });
  }
}
