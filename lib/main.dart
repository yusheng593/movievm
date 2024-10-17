import 'package:flutter/material.dart';
import 'package:movievm/constants/my_theme_data.dart';
import 'package:movievm/screens/favorites_screen.dart';
import 'package:movievm/screens/movie_details.dart';
import 'package:movievm/screens/movies_screen.dart';
import 'package:movievm/screens/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieVM',
      theme: MyThemeData.darkTheme,
      home: const MoviesScreen(),
    );
  }
}
