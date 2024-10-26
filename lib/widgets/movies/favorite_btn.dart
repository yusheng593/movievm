import 'package:flutter/material.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/view_models/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key, required this.movieModel});
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, FavoritesProvider favoritesProvider, _) {
      return IconButton(
        onPressed: () {
          favoritesProvider.addOrRemoveFromFavorites(movieModel);
        },
        icon: Icon(
          favoritesProvider.isFavorite(movieModel)
              ? MyAppIcons.favorite
              : MyAppIcons.favoriteOutlineRounded,
          color: favoritesProvider.isFavorite(movieModel)
              ? Colors.red
              : Colors.grey,
          size: 20,
        ),
      );
    });
  }
}
