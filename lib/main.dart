import 'package:easy_localization/easy_localization.dart';
import 'package:meal_tracker/application/target/target_bloc.dart';
import 'package:meal_tracker/presentation/root_page.dart';
import 'package:meal_tracker/presentation/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bootstrap.dart';
import 'application/home/home_bloc.dart';

const APP_NAME = 'Fitness-Tracker';

void main() async {
  await init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('de', 'DE')],
      path: 'assets/lang',
      fallbackLocale: Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              i<HomeBloc>()..add(HomeLoad(time: DateTime.now())),
        ),
        BlocProvider(
          create: (context) => i<TargetBloc>()..add(TargetLoadValues()),
        ),
      ],
      child: MaterialApp(
        title: 'Meal Tracker',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const RootPage(),
      ),
    );
  }
}
