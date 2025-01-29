import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.white70, // Soft off-white
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF008891), // Deep teal
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF008891), // Coral red
      foregroundColor: Colors.white,
    ),
    cardColor: const Color(0xFFFAE3D9), // Peachy pink
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF00587A)), // Deep ocean blue
      bodyMedium: TextStyle(color: Color(0xFF00587A)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Color(0xFF1E272E), // Charcoal black
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF485460), // Muted steel grey
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF485460), // Bright golden yellow
      foregroundColor: Colors.white,
    ),
  );
}






