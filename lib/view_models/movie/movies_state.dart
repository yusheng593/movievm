import 'package:movievm/models/movies_genre.dart';
import 'package:movievm/models/movies_model.dart';

class MoviesState {
  final int currentPage;

  final List<MovieModel> moviesList;

  final List<MoviesGenreModel> genresList;

  final bool isLoading;

  final String fetchMoviesError;

  MoviesState({
    this.currentPage = 1,
    this.moviesList = const [],
    this.genresList = const [],
    this.isLoading = false,
    this.fetchMoviesError = '',
  });

  MoviesState copyWith({
    int? currentPage,
    List<MovieModel>? moviesList,
    List<MoviesGenreModel>? genresList,
    bool? isLoading,
    String? fetchMoviesError,
  }) {
    return MoviesState(
      currentPage: currentPage ?? this.currentPage,
      moviesList: moviesList ?? this.moviesList,
      genresList: genresList ?? this.genresList,
      isLoading: isLoading ?? this.isLoading,
      fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
    );
  }
}
