import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class SettingsProvider extends ChangeNotifier {
  AppTheme _currentTheme = AppTheme.dark;
  AppTheme get currentTheme => _currentTheme;

  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}