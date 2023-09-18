import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Palette.backgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.backgroundColor,
    ),
  );
}
