import 'package:flutter/material.dart';
import 'package:rollshop/core/theme/colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.darkModeColor,
  );
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.whiteText,
  );
}
