part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

final class HomeLoad extends HomeEvent {
  final DateTime time;

  const HomeLoad({
    required this.time,
  });

}
final class HomeAddPressed extends HomeEvent {}
final class HomeFoodSubmitted extends HomeEvent {
  final Food food;
  final double amount;

  const HomeFoodSubmitted({
    required this.food,
    required this.amount,
  });
}
final class HomeFoodRemoved extends HomeEvent {
  final int index;

  const HomeFoodRemoved(this.index);
}