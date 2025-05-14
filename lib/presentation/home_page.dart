import 'package:fitness_tracker/application/food/food_bloc.dart';
import 'package:fitness_tracker/presentation/overview_without_target.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

  return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocConsumer<FoodBloc, FoodState>(
        listenWhen: (previous, current) => current.showDialog,
        listener: (BuildContext context, Object? state) {
          showAddDialog(context, DateTime.now().subtract(Duration(days: 10)), DateTime.now());
        },
        builder: (BuildContext context, state) {
          return Column(
            children: [
              OverviewWithoutTarget(fat: 23.3, protein: 3, carbs: 32),
              SizedBox(height: 20,),
              Divider(color: containerColorLight, thickness: 0.4,),
              SizedBox(height: 20,),
              AnimatedList(
                initialItemCount: state.consumedFoods?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index, animation) {
                  return SizeTransition(sizeFactor: animation,
                      child: Text(state.consumedFoods![index].name!));
                },)
            ],
          );
        },
      ),
    );
  }

  void showAddDialog(BuildContext context, DateTime from, DateTime to) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Essen hinzufügen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          TextField()
        ],),
        actions: [
          TextButton(onPressed: () {
            
          }, child: Text('sdfasdfsdf', style: TextStyle(color: lightErrorColor),))
        ],
      );
    },);
  }
}