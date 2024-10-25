import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/enums/theme_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeEnums>((_) => ThemeProvider());

class ThemeProvider extends StateNotifier<ThemeEnums> {
  final prefsDarkKey = 'isDarkMode';
  ThemeProvider() : super(ThemeEnums.dark) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(prefsDarkKey) ?? false;
    state = isDarkMode ? ThemeEnums.dark : ThemeEnums.light;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (state == ThemeEnums.dark) {
      state = ThemeEnums.light;
      await prefs.setBool(prefsDarkKey, false);
    } else {
      state = ThemeEnums.dark;
      await prefs.setBool(prefsDarkKey, true);
    }
  }
}
