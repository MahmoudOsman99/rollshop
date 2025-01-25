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

class AppChangeThemeModeState extends AppState {
  final ThemeMode themeMode;
  const AppChangeThemeModeState({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];
}
