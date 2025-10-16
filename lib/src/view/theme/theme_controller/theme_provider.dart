import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Default mode
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Toggle between light and dark
  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // You can also directly set a theme
  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
