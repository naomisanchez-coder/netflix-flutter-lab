import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const red = Color(0xffe50914);
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff080808),
    colorScheme: const ColorScheme.dark(
      primary: red,
      surface: Color(0xff141414),
    ),
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'BebasNeue', fontSize: 52),
      titleLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: red,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(),
    ),
  );
}
