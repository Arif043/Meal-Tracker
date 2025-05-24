import 'package:bloc/bloc.dart';
import 'package:meal_tracker/domain/repositories/food_repository.dart';
import 'package:meal_tracker/infrastructure/models/consumed_food_model.dart';
import 'package:meal_tracker/infrastructure/repositories/food_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../infrastructure/models/food_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FoodRepository _repo;

  HomeBloc(this._repo) : super(HomeState(status: HomeStatus.initial)) {
    on<HomeAddPressed>((event, emit) {
      emit(state.copyWith(status: HomeStatus.add));
    });

    on<HomeFoodSubmitted>((event, emit) async {
      await _repo.saveConsumedFood(
        event.food,
        event.amount,
      );
      add(HomeLoad(time: state.time));
      // emit(HomeState(status: HomeStatus.initial, consumedFoods: consumedFoods, time: state.time));
    });

    on<HomeLoad>((event, emit) async {
      final time = event.time;
      final foods = await _repo.loadConsumedFoods(time);

      var (accumulatedFat, accumulatedCarbs, accumulatedProtein) = (
        0.0,
        0.0,
        0.0,
      );
      for (var e in foods) {
        accumulatedFat += e.fat;
        accumulatedCarbs += e.carbs;
        accumulatedProtein += e.protein;
      }

      emit(
        HomeState(
          status: HomeStatus.initial,
          consumedFoods: foods,
          time: time,
          accumulatedCarbs: accumulatedCarbs,
          accumulatedFat: accumulatedFat,
          accumulatedProtein: accumulatedProtein,
        ),
      );
    });

    on<HomeFoodRemoved>((event, emit) async {
      final food = state.consumedFoods![event.index];
      _repo.removeConsumedFood(food);
      final current = List<ConsumedFood>.from(state.consumedFoods!);
      current.removeAt(event.index);
      final acFat = state.accumulatedFat - food.fat;
      final acCarbs = state.accumulatedCarbs - food.carbs;
      final acProtein = state.accumulatedProtein - food.protein;
      emit(state.copyWith(consumedFoods: current, accumulatedProtein: acProtein, accumulatedFat: acFat, accumulatedCarbs: acCarbs));
    },);
  }
}
