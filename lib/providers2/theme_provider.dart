import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeType {
  light,
  dark,
}

class ThemeProvider with ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.light;

  ThemeModeType get themeMode => _themeMode;

  set themeMode(ThemeModeType mode) {
    _themeMode = mode;
    _saveThemeMode(mode);
    notifyListeners();
  }

  ThemeProvider() {
    _loadThemeMode();
  }

  void _saveThemeMode(ThemeModeType mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', mode == ThemeModeType.dark);
  }

  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDarkMode ? ThemeModeType.dark : ThemeModeType.light;
    notifyListeners();
  }
}
