import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/view_models/favorites/favorites_provider.dart';
import 'package:movievm/widgets/movies/movies_widget.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('收藏'),
        actions: [
          IconButton(
            onPressed: favoritesState.favoritesList.isEmpty
                ? null
                : () {
                    ref.read(favoritesProvider.notifier).clearAllFavorites();
                  },
            icon: Icon(
              MyAppIcons.delete,
              color: favoritesState.favoritesList.isEmpty
                  ? Colors.grey
                  : Colors.red,
            ),
          )
        ],
      ),
      body: favoritesState.favoritesList.isEmpty
          ? const Center(
              child: Text(
                '~空空如也~',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: favoritesState.favoritesList.length,
              itemBuilder: (context, index) {
                return MoviesWidget(
                  movieModel:
                      favoritesState.favoritesList.reversed.toList()[index],
                );
              }),
    );
  }
}
