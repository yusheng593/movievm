import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/repository/movies_repo.dart';
import 'package:movievm/service/init_getit.dart';
import 'package:movievm/service/navigation_service.dart';
import 'package:movievm/view_models/movie/movies_state.dart';

final moviesProvider =
    StateNotifierProvider<MoviesProvider, MoviesState>((_) => MoviesProvider());

final currentMovie = Provider.family<MovieModel, int>((ref, index) {
  final movieState = ref.watch(moviesProvider);
  return movieState.moviesList[index];
});

class MoviesProvider extends StateNotifier<MoviesState> {
  MoviesProvider() : super(MoviesState());

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getMovies() async {
    if (state.isLoading) {
      return;
    }
    state = state.copyWith(isLoading: true);

    try {
      if (state.genresList.isEmpty) {
        final genresList = await _moviesRepository.fetchGenres();
        state = state.copyWith(genresList: genresList);
      }
      List<MovieModel> movies =
          await _moviesRepository.fetchMovies(page: state.currentPage);
      state = state.copyWith(
        moviesList: [...state.moviesList, ...movies],
        currentPage: state.currentPage + 1,
        fetchMoviesError: '',
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        fetchMoviesError: error.toString(),
        isLoading: false,
      );
      log('錯誤訊息: $error');
      getIt<NavigationService>().showSnackbar(error.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
