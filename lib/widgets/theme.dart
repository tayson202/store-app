import 'package:flutter/material.dart';

class AppTheme {
  // LIGHT THEME
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFF5722),
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF5722),
      brightness: Brightness.light,
    ),

    cardColor: Colors.white,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFFF5722),
      unselectedItemColor: Colors.blueGrey,
    ),
  );

  // DARK THEME
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFFF5722),
    scaffoldBackgroundColor: const Color(0xFF121212),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF5722),
      brightness: Brightness.dark,
      surface: Color(0xFF121212),
    ),

    cardColor: const Color(0xFF121212),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: Color(0xFFFF5722),
      unselectedItemColor: Colors.blueGrey,
    ),
  );
}

/*import 'package:flutter/material.dart';

class AppTheme {
  // LIGHT THEME
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFF5722),
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF5722),
      brightness: Brightness.light,
    ),

    cardColor: Colors.white,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFFF5722),
      unselectedItemColor: Colors.blueGrey,
    ),
  );

  // DARK THEME
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFFF5722),
    scaffoldBackgroundColor: const Color(0xFF121212),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF5722),
      brightness: Brightness.dark,
      surface: Color(0xFF121212),
    ),

    cardColor: const Color(0xFF121212),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: Color(0xFFFF5722),
      unselectedItemColor: Colors.blueGrey,
    ),
  );
}
*/
