import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/features/main/cubit/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  ThemeMode currentThemeMode = ThemeMode.system;
  Locale currentLocale = Locale('en', 'US');
  List<String> languagesCode = ["ar", "en"];

  // void changeAppTheme() {
  //   currentThemeMode =
  //       currentThemeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.light;
  //   emit(AppChangeThemeModeState(themeMode: currentThemeMode));
  // }

  Future<void> changeAppLocale(String localeCode) async {
    currentLocale = Locale(localeCode);
    emit(AppChangeLocaleState(locale: currentLocale));
    await _saveLocale(localeCode);
  }

  Future<void> _saveLocale(String localeCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('localeCode', localeCode);
  }

  Future<void> loadThemeAndLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode') ?? 0;
    currentThemeMode = ThemeMode.values[themeIndex];
    if (currentThemeMode == ThemeMode.system) {
      debugPrint("$currentThemeMode theme mode system");
      currentThemeMode = ThemeMode.dark;
      debugPrint("$currentThemeMode theme mode is dark");
    }

    final localeCode = prefs.getString('localeCode') ?? 'ar';
    currentLocale = Locale(localeCode);

    emit(AppLoadedState(themeMode: currentThemeMode, locale: currentLocale));
  }

  // Future<void> loadTheme() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final themeIndex = prefs.getInt('themeMode') ?? 0;
  //   currentThemeMode = ThemeMode.values[themeIndex];
  //   if (currentThemeMode == ThemeMode.system) {
  //     currentThemeMode = ThemeMode.light;
  //   }
  //   emit(AppChangeThemeModeState(themeMode: currentThemeMode));
  // }

  Future<void> changeAppTheme() async {
    currentThemeMode =
        currentThemeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(AppChangeThemeModeState(themeMode: currentThemeMode));
    await _saveTheme(currentThemeMode);
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.index);
  }
}
