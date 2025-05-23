part of 'target_bloc.dart';

@immutable
sealed class TargetEvent {
  const TargetEvent();
}

final class TargetValuesUpdated extends TargetEvent{
  final int fat, carbs, protein;

  const TargetValuesUpdated({
    required this.fat,
    required this.carbs,
    required this.protein,
  });
}

final class TargetLoadValues extends TargetEvent {}