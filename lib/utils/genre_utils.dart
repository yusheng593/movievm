import 'package:movievm/models/movies_genre.dart';
import 'package:movievm/repository/movies_repo.dart';
import 'package:movievm/service/init_getit.dart';

class GenreUtils {
  static List<MoviesGenreModel> moviesGenreNames(List<int> genreIds) {
    final List<MoviesGenreModel> genresNames = [];
    final cachedGenres = getIt<MoviesRepository>().cachedGenres;
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
