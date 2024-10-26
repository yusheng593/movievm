import 'package:flutter/material.dart';
import 'package:movievm/screens/movies_screen.dart';
import 'package:movievm/service/init_getit.dart';
import 'package:movievm/service/navigation_service.dart';
import 'package:movievm/view_models/favorites_provider.dart';
import 'package:movievm/view_models/movies_provider.dart';
import 'package:movievm/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _loadInitiaData(BuildContext context) async {
    await Future.microtask(() async {
      if (!context.mounted) return;
      await Provider.of<FavoritesProvider>(context, listen: false)
          .loadFavorites();
      if (!context.mounted) return;
      await Provider.of<MoviesProvider>(context, listen: false).getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
          future: _loadInitiaData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            } else if (snapshot.hasError) {
              if (moviesProvider.genresList.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  getIt<NavigationService>()
                      .navigatePushReplacement(const MoviesScreen());
                });
              }
              return Provider.of<MoviesProvider>(context).isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : MyErrorWidget(
                      errorText: snapshot.error.toString(),
                      retryFunction: () async {
                        await _loadInitiaData(context);
                      });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                getIt<NavigationService>()
                    .navigatePushReplacement(const MoviesScreen());
              });

              return const SizedBox.shrink(); // 無限小的佔位 widget
            }
          }),
    );
  }
}
