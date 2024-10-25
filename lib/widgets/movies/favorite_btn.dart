import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/view_models/favorites/favorites_provider.dart';

// class FavoriteBtnWidget extends ConsumerWidget {
//   const FavoriteBtnWidget({super.key, required this.movieModel});
//   final MovieModel movieModel;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final favoritesState = ref.watch(favoritesProvider);
//     final isFavorite = favoritesState.favoritesList.contains(movieModel);
//     return IconButton(
//       onPressed: () {
//         ref
//             .read(favoritesProvider.notifier)
//             .addOrRemoveFromFavorites(movieModel);
//       },
//       icon: Icon(
//         isFavorite ? MyAppIcons.favorite : MyAppIcons.favoriteOutlineRounded,
//         color: isFavorite ? Colors.red : null,
//         size: 20,
//       ),
//     );
//   }
// }

class FavoriteBtnWidget extends ConsumerWidget {
  const FavoriteBtnWidget({super.key, required this.movieModel});
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 只是為了用看看Provider.select
    final favoritesList =
        ref.watch(favoritesProvider.select((state) => state.favoritesList));
    final isFavorite = favoritesList.any((movie) => movie.id == movieModel.id);
    return IconButton(
      onPressed: () {
        ref
            .read(favoritesProvider.notifier)
            .addOrRemoveFromFavorites(movieModel);
      },
      icon: Icon(
        isFavorite ? MyAppIcons.favorite : MyAppIcons.favoriteOutlineRounded,
        color: isFavorite ? Colors.red : null,
        size: 20,
      ),
    );
  }
}
