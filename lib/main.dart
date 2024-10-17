import 'package:flutter/material.dart';
import 'package:movievm/constants/my_theme_data.dart';
import 'package:movievm/screens/movies_screen.dart';
import 'package:movievm/service/init_getit.dart';
import 'package:movievm/service/navigation_service.dart';

void main() {
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'MovieVM',
      theme: MyThemeData.darkTheme,
      home: const MoviesScreen(),
    );
  }
}
