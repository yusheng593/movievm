import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/screens/movies_screen.dart';
import 'package:movievm/service/init_getit.dart';
import 'package:movievm/service/navigation_service.dart';
import 'package:movievm/view_models/favorites/favorites_provider.dart';
import 'package:movievm/view_models/movie/movies_provider.dart';
import 'package:movievm/widgets/my_error_widget.dart';

final initProvider = FutureProvider.autoDispose<void>((ref) async {
  ref.keepAlive();
  await Future.microtask(() async {
    await ref.read(favoritesProvider.notifier).loadFavorites();
    await ref.read(moviesProvider.notifier).getMovies();
  });
});

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(initProvider);
    return initWatch.when(data: (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getIt<NavigationService>()
            .navigatePushReplacement(const MoviesScreen());
      });

      return const SizedBox.shrink();
    }, error: (error, _) {
      log('🐒${error.toString()}');
      return MyErrorWidget(
          errorText: error.toString(),
          retryFunction: () => ref.refresh(initProvider));
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}
