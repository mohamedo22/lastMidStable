import 'package:flutter/material.dart';

class MyAppTheme {
    static const primaryLight = Color(0xFF2F05AE);
  static ThemeData myLightThmeme = ThemeData(
      primaryColor: primaryLight,
      scaffoldBackgroundColor: primaryLight,
      textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          bodySmall:TextStyle( fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)));
}
