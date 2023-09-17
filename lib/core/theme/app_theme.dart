import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Pallete.whiteColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.greyColor,
    ),
  );
}
