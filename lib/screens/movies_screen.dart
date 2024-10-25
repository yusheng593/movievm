import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/enums/theme_enums.dart';
import 'package:movievm/screens/favorites_screen.dart';
import 'package:movievm/service/init_getit.dart';
import 'package:movievm/service/navigation_service.dart';
import 'package:movievm/view_models/movie/movies_provider.dart';
import 'package:movievm/view_models/theme_provider.dart';
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
          Consumer(
            builder: (context, ref, child) {
              final themeState = ref.watch(themeProvider);
              return IconButton(
                onPressed: () async {
                  await ref.read(themeProvider.notifier).toggleTheme();
                },
                icon: Icon(themeState == ThemeEnums.dark
                    ? MyAppIcons.darkMode
                    : MyAppIcons.lightMode),
              );
            },
          )
        ],
      ),
      body: Consumer(builder: (context, WidgetRef ref, child) {
        final movieState = ref.watch(moviesProvider);

        if (movieState.isLoading && movieState.moviesList.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (movieState.fetchMoviesError.isNotEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !movieState.isLoading) {
                Future.microtask(() async {
                  await ref.read(moviesProvider.notifier).getMovies();
                });
                return true;
              }
              return false;
            },
            child: ListView.builder(
                itemCount: movieState.moviesList.length,
                itemBuilder: (context, index) {
                  return MoviesWidget(
                    movieModel: movieState.moviesList[index],
                  );
                }),
          );
        }
      }),
    );
  }
}
