import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/view_models/favorites/favorites_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesProvider, FavoritesState>(
        (_) => FavoritesProvider());

final currentfavoriteMovie = Provider.family<MovieModel, int>((ref, index) {
  final movieState = ref.watch(favoritesProvider);
  return movieState.favoritesList[index];
});

class FavoritesProvider extends StateNotifier<FavoritesState> {
  FavoritesProvider() : super(FavoritesState());

  final favoritesKey = 'favoritesKey';

  bool isFavorite(MovieModel movieModel) {
    return state.favoritesList.any((movie) => movie.id == movieModel.id);
  }

  Future<void> addOrRemoveFromFavorites(MovieModel movieModel) async {
    bool wasFavorite = isFavorite(movieModel);
    final List<MovieModel> updatedFavorites = wasFavorite
        ? state.favoritesList
            .where(
              (element) => element.id != movieModel.id,
            )
            .toList()
        : [...state.favoritesList, movieModel];
    state = state.copyWith(favoritesList: updatedFavorites);
    await saveFavorites();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = state.favoritesList
        .map((movie) => json.encode(movie.toJson()))
        .toList();
    prefs.setStringList(favoritesKey, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(favoritesKey) ?? [];
    final List<MovieModel> newFavoritesList = stringList
        .map((movie) => MovieModel.fromJson(json.decode(movie)))
        .toList();

    state = state.copyWith(favoritesList: newFavoritesList);
  }

  void clearAllFavorites() {
    state = state.copyWith(favoritesList: []);

    saveFavorites();
  }
}
