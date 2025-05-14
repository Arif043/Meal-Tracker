import 'package:fitness_tracker/application/food/food_bloc.dart';
import 'package:fitness_tracker/presentation/root_page.dart';
import 'package:fitness_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

void main() {
  OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Fitness-Tracker/1.0 (arif.ertugrul@outlook.com)', url: 'https://github.com/arif043');

  OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
    OpenFoodFactsLanguage.ENGLISH
  ];

  OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.GERMANY;

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