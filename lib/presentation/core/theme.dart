import 'package:flutter/material.dart';

const Color a = Color(0xFFB09398);
const Color b = Color(0xFF564946);

final Color lightPrimaryColor = Colors.red;
final Color lightPrimaryVariantColor = Colors.blue;
final Color lightOnPrimaryColor = Colors.white;
final Color lightSurfaceColor = Color(0xFFfef1e3);
const Color lightTextColorPrimary = Colors.black;
const Color lightErrorColor = Colors.redAccent;
final Color lightSuccess = Colors.green[700] ?? Colors.green;
// Color unselectedLabelColor = Colors.
final lightScaffoldColor = lightSurfaceColor;
const Color appbarColorLight = Color(0xFFFCD0A1);
const Color containerTextColorLight = Colors.black87;
const Color containerColorLight = Color(0xFFDDF0FF);

final Color darkPrimaryColor = Colors.blueGrey.shade900;
const Color darkPrimaryVariantColor = Colors.black;
final Color darkOnPrimaryColor = Colors.blueGrey.shade300;
const Color darkTextColorPrimary = Colors.white;
final Color appbarColorDark = Colors.blueGrey.shade800;

const Color iconColor = Colors.red;

const Color accentColorDark = Color.fromRGBO(74, 217, 217, 1);

const TextStyle lightHeadingText = TextStyle(
  color: lightTextColorPrimary,
  fontFamily: "Rubik",
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const TextStyle lightBodyText = TextStyle(fontFamily: 'Rubik');

const TextStyle lightDetailTitle = TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.bold, fontSize: 16);

const TextTheme lightTextTheme = TextTheme(
  displayLarge: lightHeadingText,
  bodyMedium: lightBodyText,
);

final TextStyle darkThemeHeadingTextStyle = lightHeadingText.copyWith(
  color: darkTextColorPrimary,
);

final TextStyle darkBodyText = lightBodyText.copyWith();

final TextTheme darkTextTheme = TextTheme(
  displayLarge: darkThemeHeadingTextStyle,
  bodyLarge: darkBodyText,
);

final FloatingActionButtonThemeData lightFloatingTheme =
    FloatingActionButtonThemeData(
      backgroundColor: appbarColorLight,
      foregroundColor: Color(0xff006abe),
    );

final IconThemeData iconTheme = IconThemeData(color: iconColor);

final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: appbarColorLight,
  outlineBorder: BorderSide(color: Colors.orange),
  floatingLabelStyle: const TextStyle(color: containerTextColorLight),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    //borderSide: const BorderSide(color: Colors.white),
  ),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  hintStyle: TextStyle(color: Colors.black54),
  labelStyle: TextStyle(color: Colors.black54)
);

final TabBarThemeData lightTabBarTheme = TabBarThemeData(
  dividerColor: Colors.blue,
  indicatorColor: Colors.blue,
  labelStyle: lightBodyText.copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
  unselectedLabelStyle: TextStyle(color: Colors.blue),
);

final ThemeData lightTheme = ThemeData(
  tabBarTheme: lightTabBarTheme,
  inputDecorationTheme: inputDecorationTheme,
  scaffoldBackgroundColor: lightScaffoldColor,
  appBarTheme: AppBarTheme(
    color: appbarColorLight,
    iconTheme: iconTheme,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: appbarColorLight),
  colorScheme: ColorScheme.light(
    primary: lightPrimaryColor,
    onPrimary: lightOnPrimaryColor,
    secondary: accentColorDark,
    primaryContainer: lightPrimaryVariantColor,
  ),
  textTheme: lightTextTheme,
  floatingActionButtonTheme: lightFloatingTheme,
  iconTheme: iconTheme
);

final ThemeData darkTheme = ThemeData(
  inputDecorationTheme: inputDecorationTheme,
  scaffoldBackgroundColor: darkPrimaryColor,
  appBarTheme: AppBarTheme(
    color: appbarColorDark,
    iconTheme: const IconThemeData(color: iconColor),
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: appbarColorDark),
  colorScheme: ColorScheme.dark(
    primary: darkPrimaryColor,
    secondary: accentColorDark,
    onPrimary: darkOnPrimaryColor,
    primaryContainer: darkPrimaryVariantColor,
  ),
  textTheme: darkTextTheme,
);
