part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class FoodLoadEvent extends FoodEvent {}
final class FoodAddPressed extends FoodEvent {}
final class FoodCancelPressed extends FoodEvent {}
final class FoodAdd extends FoodEvent {
  final ConsumedFood food;

  FoodAdd(this.food);
}

final class FoodRequested extends FoodEvent {
  final String searchTerm;
  FoodRequested(this.searchTerm);
}
final class FoodRemoteRequested extends FoodEvent {
  final String searchTerm;
  FoodRemoteRequested(this.searchTerm);
}