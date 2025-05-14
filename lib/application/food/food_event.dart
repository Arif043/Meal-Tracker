part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class LoadFoodEvent extends FoodEvent {}
final class AddFoodEvent extends FoodEvent {
  final ConsumedFood food;

  AddFoodEvent(this.food);
}

final class FoodRequestedEvent extends FoodEvent {
  final String searchTerm;

  FoodRequestedEvent(this.searchTerm);
}