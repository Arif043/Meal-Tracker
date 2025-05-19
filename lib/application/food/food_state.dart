part of 'food_bloc.dart';

@immutable
class FoodState {
  final List<ConsumedFood>? consumedFoods;
  final DateTime? date;

  FoodState({this.consumedFoods = const [], DateTime? date})
    : date = date ?? DateTime.now();

  FoodState copyWith({List<ConsumedFood>? consumedFoods, DateTime? date}) {
    return FoodState(
      consumedFoods: consumedFoods ?? this.consumedFoods,
      date: date ?? this.date,
    );
  }
}

final class FoodAddState extends FoodState {
  final List<Food>? requestedFoods;
  final String? term;
  FoodAddState({
    this.requestedFoods,
    this.term,
    super.consumedFoods,
    super.date,
  });

  @override
  FoodAddState copyWith({
    List<Food>? requestedFoods,
    String? term,
    List<ConsumedFood>? consumedFoods,
    DateTime? date,
  }) {
    return FoodAddState(
      requestedFoods: requestedFoods ?? this.requestedFoods,
      term: term ?? this.term,
      consumedFoods: consumedFoods ?? this.consumedFoods,
      date: date ?? this.date,
    );
  }
}
