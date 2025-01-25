import 'package:flutter/material.dart';
import 'package:rollshop/core/theme/colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.orangeColor, // Your primary color
      brightness: Brightness.dark,
      background: ColorsManager.darkModeColor,
      onBackground: ColorsManager.whiteText,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: ColorsManager.whiteText),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.darkModeColor,
      titleTextStyle: TextStyle(color: ColorsManager.whiteText),
      iconTheme: IconThemeData(color: ColorsManager.whiteText),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.orangeColor, // Your primary color
      brightness: Brightness.light,
      background: ColorsManager.whiteColor,
      onBackground: ColorsManager.blackText,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: ColorsManager.blackText),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.whiteColor,
      titleTextStyle: TextStyle(color: ColorsManager.blackText),
      iconTheme: IconThemeData(color: ColorsManager.blackText),
    ),
  );
}
