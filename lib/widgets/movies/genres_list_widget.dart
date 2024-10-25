import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/utils/genre_utils.dart';

class GenresListWidget extends ConsumerWidget {
  const GenresListWidget(this.movieModel, {super.key});
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genresList =
        GenreUtils.moviesGenreNames(genreIds: movieModel.genreIds, ref: ref);
    return Wrap(
      children: List.generate(
        genresList.length,
        (index) => chipWidget(
            genreName: genresList[index].name ?? '', context: context),
      ),
    );
  }

  Widget chipWidget(
      {required String genreName, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
          border: Border.all(color: Theme.of(context).colorScheme.tertiary),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          genreName,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
        ),
      ),
    );
  }
}
