part of 'food_bloc.dart';

@immutable
class FoodState {
  final bool showDialog;
  final List<ConsumedFood>? consumedFoods;
  final List<Food>? requestedFoods;
  final DateTime? date;

  FoodState({this.showDialog = false, List<ConsumedFood>? consumedFoods, List<Food>? requestedFoods, DateTime? date})
    : consumedFoods = consumedFoods ?? const [],
      requestedFoods = requestedFoods ?? const [],
      date = date ?? DateTime.now();

  FoodState copyWith({
    bool? showDialog,
    List<ConsumedFood>? consumedFoods,
    List<Food>? requestedFoods,
    DateTime? date,
  }) {
    return FoodState(
      showDialog: showDialog ?? this.showDialog,
      consumedFoods: consumedFoods ?? this.consumedFoods,
      requestedFoods: requestedFoods ?? this.requestedFoods,
      date: date ?? this.date,
    );
  }

}
