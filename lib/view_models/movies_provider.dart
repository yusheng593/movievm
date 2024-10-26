import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movievm/models/movies_genre.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/repository/movies_repo.dart';
import 'package:movievm/service/init_getit.dart';
import 'package:movievm/service/navigation_service.dart';

class MoviesProvider with ChangeNotifier {
  int _currentPage = 1;
  int get currentPage => _currentPage;

  final List<MovieModel> _moviesList = [];
  List<MovieModel> get moviesList => _moviesList;

  List<MoviesGenreModel> _genresList = [];
  List<MoviesGenreModel> get genresList => _genresList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _fetchMoviesError = '';
  String get fetchMoviesError => _fetchMoviesError;

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  final List<MovieModel> _favoritesMovies = [];
  List<MovieModel> get favoritesMovies => _favoritesMovies;
  set favoritesMovies(List<MovieModel> movies) {
    _favoritesMovies.clear();
    _favoritesMovies.addAll(movies);
    notifyListeners();
  }

  Future<void> getMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_genresList.isEmpty) {
        _genresList = await _moviesRepository.fetchGenres();
      }
      List<MovieModel> movies =
          await _moviesRepository.fetchMovies(page: _currentPage);
      _moviesList.addAll(movies); // 將第二頁數據加入
      _currentPage++;
      _fetchMoviesError = '';
    } catch (error) {
      _fetchMoviesError = error.toString();
      log('錯誤訊息: $error');
      getIt<NavigationService>().showSnackbar(error.toString());
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
