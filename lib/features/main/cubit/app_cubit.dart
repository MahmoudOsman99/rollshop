import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/features/main/cubit/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  ThemeMode currentThemeMode = ThemeMode.system;

  // void changeAppTheme() {
  //   currentThemeMode =
  //       currentThemeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.light;
  //   emit(AppChangeThemeModeState(themeMode: currentThemeMode));
  // }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode') ?? 0;
    currentThemeMode = ThemeMode.values[themeIndex];
    if (currentThemeMode == ThemeMode.system) {
      currentThemeMode = ThemeMode.light;
    }
    emit(AppChangeThemeModeState(themeMode: currentThemeMode));
  }

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
