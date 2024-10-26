import 'package:flutter/material.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/view_models/favorites_provider.dart';
import 'package:movievm/widgets/movies/movies_widget.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('收藏'),
        actions: [
          IconButton(
            onPressed: () {
              favoritesProvider.clearAllFavorites();
            },
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: favoritesProvider.favoritesList.isEmpty
          ? const Center(
              child: Text(
                '~空空如也~',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: favoritesProvider.favoritesList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value:
                      favoritesProvider.favoritesList.reversed.toList()[index],
                  child: const MoviesWidget(),
                );
              },
            ),
    );
  }
}
