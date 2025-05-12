import 'package:flutter/material.dart';

class OverviewWithoutTarget extends StatelessWidget {

  final double carbs, fat, protein;
  const OverviewWithoutTarget({super.key, required this.fat, required this.protein, required this.carbs});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(carbs),
          Text(fat),
          Text(protein)
        ],
      ),
    );
  }
}
