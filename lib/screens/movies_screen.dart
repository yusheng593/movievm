import 'package:flutter/material.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/constants/my_theme_data.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/screens/favorites_screen.dart';
import 'package:movievm/service/init_getit.dart';
import 'package:movievm/service/navigation_service.dart';
import 'package:movievm/view_models/movies_provider.dart';
import 'package:movievm/view_models/theme_provider.dart';
import 'package:movievm/widgets/movies/movies_widget.dart';
import 'package:provider/provider.dart';

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
          Consumer(
            builder:
                (BuildContext context, ThemeProvider themeProvider, child) {
              return IconButton(
                onPressed: () async {
                  themeProvider.toggleTheme();
                },
                icon: Icon(themeProvider.themeData == MyThemeData.darkTheme
                    ? MyAppIcons.darkMode
                    : MyAppIcons.lightMode),
              );
            },
          )
        ],
      ),
      body: Consumer(builder: (context, MoviesProvider moviesProvider, child) {
        final List<MovieModel> movies = moviesProvider.moviesList;
        if (moviesProvider.isLoading && moviesProvider.moviesList.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (moviesProvider.fetchMoviesError.isNotEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !moviesProvider.isLoading) {
                moviesProvider.getMovies();
                return true;
              }
              return false;
            },
            child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: movies[index],
                    child: const MoviesWidget(),
                  );
                }),
          );
        }
      }),
    );
  }
}
