import 'package:flutter/material.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/widgets/movies/movies_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('熱門影片'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              MyAppIcons.favoriteRounded,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(MyAppIcons.darkmode),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const MoviesWidget();
          }),
    );
  }
}
