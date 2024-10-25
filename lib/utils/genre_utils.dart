import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/models/movies_genre.dart';
import 'package:movievm/view_models/movie/movies_provider.dart';

class GenreUtils {
  static List<MoviesGenreModel> moviesGenreNames(
      {required List<int> genreIds, required WidgetRef ref}) {
    final moviesState = ref.watch(moviesProvider);
    final cachedGenres = moviesState.genresList;
    final List<MoviesGenreModel> genresNames = [];
    for (var genreId in genreIds) {
      var genre = cachedGenres.firstWhere(
        (g) => g.id == genreId,
        // 如果匹配不到id，就返回一個 Unknown，後續不加入列表避免顯示。
        orElse: () => MoviesGenreModel(id: 9527, name: 'Unknown'),
      );
      if (genre.id != 9527) {
        genresNames.add(genre);
      }
    }
    return genresNames;
  }
}
