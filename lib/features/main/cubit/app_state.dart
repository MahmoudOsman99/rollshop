import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitialState extends AppState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AppLoadedState extends AppState {
  final ThemeMode themeMode;
  final Locale locale;
  const AppLoadedState({required this.themeMode, required this.locale});

  @override
  List<Object?> get props => [themeMode];
}

class AppChangeThemeModeState extends AppState {
  final ThemeMode themeMode;
  const AppChangeThemeModeState({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];
}

class AppChangeLocaleState extends AppState {
  final Locale locale;
  const AppChangeLocaleState({required this.locale});

  @override
  List<Object?> get props => [locale];
}
