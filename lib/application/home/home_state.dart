part of 'home_bloc.dart';

enum HomeStatus {initial, add}
class HomeState {
  final HomeStatus status;
  final List<ConsumedFood>? consumedFoods;
  final DateTime time;
  final double accumulatedFat;
  final double accumulatedCarbs;
  final double accumulatedProtein;

  HomeState({
    required this.status,
    this.consumedFoods,
    this.accumulatedCarbs = 0,
    this.accumulatedFat = 0,
    this.accumulatedProtein = 0,
    DateTime? time
  }) : time = time ?? DateTime.now();

  HomeState copyWith({
    HomeStatus? status,
    List<ConsumedFood>? consumedFoods,
    DateTime? time,
    double? accumulatedFat,
    double? accumulatedCarbs,
    double? accumulatedProtein,
  }) {
    return HomeState(
      status: status ?? this.status,
      consumedFoods: consumedFoods ?? this.consumedFoods,
      time: time ?? this.time,
      accumulatedFat: accumulatedFat ?? this.accumulatedFat,
      accumulatedCarbs: accumulatedCarbs ?? this.accumulatedCarbs,
      accumulatedProtein: accumulatedProtein ?? this.accumulatedProtein,
    );
  }

}

