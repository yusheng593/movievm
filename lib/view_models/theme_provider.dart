import 'package:flutter/material.dart';
import 'package:movievm/constants/my_theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeModel = MyThemeData.lightTheme;
  ThemeData get themeData => _themeModel;

  final String themeKey = 'isDarkMode';

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkModel = prefs.getBool(themeKey) ?? false;
    _themeModel = isDarkModel ? MyThemeData.darkTheme : MyThemeData.lightTheme;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeModel = _themeModel == MyThemeData.darkTheme
        ? MyThemeData.lightTheme
        : MyThemeData.darkTheme;

    await prefs.setBool(themeKey, _themeModel == MyThemeData.darkTheme);
    notifyListeners();
  }
}
