import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/models/movies_genre.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/repository/movies_repo.dart';
import 'package:movievm/screens/favorites_screen.dart';
import 'package:movievm/service/init_getit.dart';
import 'package:movievm/service/navigation_service.dart';
import 'package:movievm/widgets/movies/movies_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('熱門影片'),
        actions: [
          IconButton(
            onPressed: () {
              getIt<NavigationService>().navigate(const FavoritesScreen());
            },
            icon: const Icon(
              MyAppIcons.favoriteRounded,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () async {
              final List<MovieModel> moviews =
                  await getIt<MoviesRepository>().fetchMovies();
              log('movie: $moviews');

              final List<MoviesGenreModel> genres =
                  await getIt<MoviesRepository>().fetchGenres();
              log('movie: $genres');
            },
            icon: const Icon(MyAppIcons.darkmode),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const MoviesWidget();
          }),
    );
  }
}
