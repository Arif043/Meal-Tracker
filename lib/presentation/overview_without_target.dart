import 'package:fitness_tracker/application/home/home_bloc.dart';
import 'package:fitness_tracker/presentation/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/target/target_bloc.dart';
import 'core/format.dart';

class OverviewWithoutTarget extends StatelessWidget {
  final double carbs, fat, protein;
  final DateTime? initial;
  const OverviewWithoutTarget({
    super.key,
    required this.fat,
    required this.protein,
    required this.carbs,
    required this.initial,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12),
          color: containerColorLight,
          elevation: 12,
          child: InkWell(
            onTap: () => showCalender(context),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: BlocBuilder<TargetBloc, TargetState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(
                            style: lightHeadingText.copyWith(
                              color: containerTextColorLight,
                            ),
                            "Kohlenhydrate ${pretty(carbs)}g${state.carbs != 0 ? ' / ${state.carbs}g' : ''}",
                          ),
                          Text(
                            style: lightHeadingText.copyWith(
                              color: containerTextColorLight,
                            ),
                            "Fett ${pretty(fat)}g${state.fat != 0 ? ' / ${state.fat}g' : ''}",
                          ),
                          Text(
                            style: lightHeadingText.copyWith(
                              color: containerTextColorLight,
                            ),
                            "Protein ${pretty(protein)}g${state.protein != 0 ? ' / ${state.protein}g' : ''}",
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showCalender(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 10)),
      lastDate: DateTime.now(),
      initialDate: initial,
    );
    debugPrint(date.toString());
    if (date != null) {
      context.read<HomeBloc>().add(HomeLoad(time: date));
    }
  }
}
