import 'package:flutter/material.dart';

class Theme {
  //light
  static final light = ThemeData(
    primaryColor: const Color(0xFFff5722),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFff5722),
      primary: const Color(0xFFff5722),
      brightness: Brightness.light,
      surface: Colors.white,
    ),
    cardColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFff5722),
      unselectedItemColor: Colors.blueGrey,
    ),
  );
  //dark
  static final dark = ThemeData(
    primaryColor: const Color(0xFFff5722),
    scaffoldBackgroundColor: const Color(0xFF121212),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: const Color(0xFF121212),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFff5722),
      primary: const Color(0xFFff5722),
      brightness: Brightness.dark,
      surface: const Color(0xFF121212),
    ),
    cardColor: const Color(0xFF121212),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF121212),
      selectedItemColor: Color(0xFFff5722),
      unselectedItemColor: Colors.blueGrey,
    ),
  );
}
