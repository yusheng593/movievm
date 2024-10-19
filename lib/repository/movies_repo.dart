import 'package:movievm/models/movies_genre.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/service/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;
  List<MoviesGenreModel> cachedGenres = [];

  MoviesRepository(this._apiService);

  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    return await _apiService.fetchMovies(page: page);
  }

  Future<List<MoviesGenreModel>> fetchGenres() async {
    return cachedGenres = await _apiService.fetchGenres();
  }
}
