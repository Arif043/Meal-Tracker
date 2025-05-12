import 'package:fitness_tracker/presentation/overview_without_target.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OverviewWithoutTarget(fat: 23, protein: 3, carbs: 32)
      ],
    );
  }
}
