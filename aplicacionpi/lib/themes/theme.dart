import 'package:flutter/material.dart';

class MainTheme {
  static Color get primaryColor => const Color(0xFF47C8C0);
  static Color get accentColor => const Color(0xFFFF629D);
  static Color get disabledColor => const Color(0xFF575757);

  static ThemeData get theme => ThemeData(
      // backgroundColor: const Color(0xFF262626),
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      accentColor: accentColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              const Set<MaterialState> interactiveStates = <MaterialState>{
                MaterialState.disabled,
              };
              if (states.any(interactiveStates.contains)) {
                return disabledColor;
              }
              return primaryColor;
            },
          ),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
        ),
      ),
      textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.4),
          headline2: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.4),
          headline3: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.4),
          bodyText1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.4),
          bodyText2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.25),
          subtitle1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.15)));
}
