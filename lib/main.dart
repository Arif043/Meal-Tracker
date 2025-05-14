import 'package:fitness_tracker/application/food/food_bloc.dart';
import 'package:fitness_tracker/presentation/root_page.dart';
import 'package:fitness_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: BlocProvider(
          create: (context) => FoodBloc(),
          lazy: false,
          child: const RootPage()),
    );
  }
}