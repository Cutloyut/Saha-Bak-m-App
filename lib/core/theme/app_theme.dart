import 'dart:developer';

import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    log("Tema Degiştirildi");
    notifyListeners();
  }

  // final double titleMediumTextSize = 15;

  final ThemeData lightMode = ThemeData.light().copyWith(
    primaryColor: Color.fromARGB(255, 47, 123, 186),
    scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),

    cardTheme: CardThemeData(
      margin: EdgeInsets.symmetric(horizontal: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: BorderSide(color: Colors.black, width: 1.3),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.red,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: Colors.green,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1.3),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
    textTheme: ThemeData.light().textTheme.copyWith(
      titleMedium: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
  final ThemeData darkMode = ThemeData.dark().copyWith(
    primaryColor: Color.fromARGB(255, 10, 66, 113),
    scaffoldBackgroundColor: Color.fromARGB(255, 24, 24, 24),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 1.3),
        ),
      ),
    ),

    cardTheme: CardThemeData(
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: BorderSide(color: Colors.white, width: 1.3),
      ),
    ),

    textTheme: ThemeData.dark().textTheme.copyWith(
      titleMedium: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
