import 'package:bloc/bloc.dart';
import 'package:fitness_tracker/infrastructure/repositories/food_repository.dart';
import 'package:meta/meta.dart';

import '../../infrastructure/models/consumed_food_model.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {

  final _repo = FoodRepository();

  FoodBloc() : super(FoodState()) {
    on<LoadFoodEvent>((event, emit) {

    });

    on<AddFoodEvent>((event, emit) {
      _repo.saveConsumedFood(event.food);
      emit(state.copyWith(consumedFoods: [...?state.consumedFoods, event.food], showDialog: true));
    },);
  }
}