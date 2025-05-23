part of 'add_bloc.dart';

@immutable
sealed class AddState {
  final String searchInput;
  const AddState({this.searchInput = ''});
}

final class AddInitial extends AddState {}
final class AddShowRecommendation extends AddState {}
final class AddLoading extends AddState {}
final class AddShowDetails extends AddState {
  final List<Food> requestedFoods;
  final int index;

  const AddShowDetails({
    required this.requestedFoods,
    required this.index,
  });

}
final class AddSuccess extends AddState {
  final List<Food> requestedFoods;
  final int pageNumber;
  const AddSuccess({
    required this.requestedFoods,
    required this.pageNumber,
    required super.searchInput,
  });
}
final class AddError extends AddState {
  final Failure failure;

  const AddError({
    required this.failure,
  });

}
