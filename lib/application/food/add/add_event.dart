part of 'add_bloc.dart';

@immutable
sealed class AddEvent {
  const AddEvent();
}

final class AddRequestRecommendation extends AddEvent {}
final class AddRequested extends AddEvent {
  final String searchTerm;
  AddRequested(this.searchTerm);
}
final class AddItemSelected extends AddEvent {
  final int index;

  const AddItemSelected({
    required this.index,
  });
}
final class AddRemoteRequested extends AddEvent {
  final String searchTerm;
  AddRemoteRequested(this.searchTerm);
}

final class AddBackToResults extends AddEvent {}