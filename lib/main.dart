import 'package:fitness_tracker/application/food/food_bloc.dart';
import 'package:fitness_tracker/presentation/root_page.dart';
import 'package:fitness_tracker/presentation/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const APP_NAME = 'Fitness-Tracker';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => FoodBloc(),
      child: MaterialApp(
        title: 'Fitness',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const RootPage(),
      ),
    );
  }
}