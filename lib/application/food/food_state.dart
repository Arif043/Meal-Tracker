part of 'food_bloc.dart';

@immutable
class FoodState {
  final bool showDialog;
  final List<ConsumedFood>? consumedFoods;
  final DateTime? date;

  FoodState({this.showDialog = false, consumedFoods, DateTime? date})
    : consumedFoods = consumedFoods ?? const [],
      date = date ?? DateTime.now();

  FoodState copyWith({
    bool? showDialog,
    List<ConsumedFood>? consumedFoods,
    DateTime? date,
  }) {
    return FoodState(
      showDialog: showDialog ?? this.showDialog,
      consumedFoods: consumedFoods ?? this.consumedFoods,
      date: date ?? this.date,
    );
  }
}
