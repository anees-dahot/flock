import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    emit(isDarkTheme ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() async {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);
    _saveTheme(newTheme);
  }

  void setTheme(ThemeMode themeMode) {
    emit(themeMode);
    _saveTheme(themeMode);
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', themeMode == ThemeMode.dark);
  }
}
