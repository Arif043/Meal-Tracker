import 'package:fitness_tracker/presentation/core/theme.dart';
import 'package:flutter/material.dart';

import 'core/format.dart';

class OverviewWithoutTarget extends StatelessWidget {

  final double carbs, fat, protein;
  const OverviewWithoutTarget({super.key, required this.fat, required this.protein, required this.carbs});
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Column(children: [
                  Text(style: lightHeadingText.copyWith(color: containerTextColorLight),"Kohlenhydrate ${pretty(carbs)}g"),
                  Text(style: lightHeadingText.copyWith(color: containerTextColorLight),"Fett ${pretty(fat)}g"),
                  Text(style: lightHeadingText.copyWith(color: containerTextColorLight),"Protein ${pretty(protein)}")
                ],),),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showCalender(BuildContext context) {
    showDatePicker(context: context, firstDate: DateTime.now().subtract(Duration(days: 10)), lastDate: DateTime.now(), );
  }
}
