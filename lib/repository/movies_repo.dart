import 'package:movievm/models/movies_genre.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/service/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;

  MoviesRepository(this._apiService);

  Future<List<MovieModel>> fetchMovies({required int page}) async {
    return await _apiService.fetchMovies(page: page);
  }

  Future<List<MoviesGenreModel>> fetchGenres() async {
    return await _apiService.fetchGenres();
  }
}
