import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings_provider.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData;
  ThemeData get themeData => _themeData;

  void updateTheme(AppTheme appTheme) {
    if (appTheme == AppTheme.light) {
      _themeData = ThemeData.light();
    } else {
      _themeData = ThemeData.dark();
    }
    notifyListeners();
  }
}