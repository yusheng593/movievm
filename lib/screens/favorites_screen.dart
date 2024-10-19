import 'package:flutter/material.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/widgets/movies/movies_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('收藏'),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Placeholder(); //MoviesWidget();
          }),
    );
  }
}
