part of 'add_bloc.dart';

@immutable
sealed class AddEvent {
  const AddEvent();
}

final class AddRequestRecommendation extends AddEvent {}
final class AddRequested extends AddEvent {
  final String searchTerm;
  const AddRequested(this.searchTerm);
}
final class AddItemSelected extends AddEvent {
  final int index;

  const AddItemSelected({
    required this.index,
  });
}
final class AddBackToResults extends AddEvent {}
final class AddItemSubmitted extends AddEvent {
  final double amount;
  const AddItemSubmitted({
    required this.amount,
  });
}
final class AddNextPagePressed extends AddEvent{}
final class AddPreviousPagePressed extends AddEvent{}