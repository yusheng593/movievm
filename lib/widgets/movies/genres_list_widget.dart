import 'package:flutter/material.dart';
import 'package:movievm/models/movies_genre.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/utils/genre_utils.dart';

class GenresListWidget extends StatelessWidget {
  const GenresListWidget({super.key, required this.moviesModel});
  final MovieModel moviesModel;

  @override
  Widget build(BuildContext context) {
    List<MoviesGenreModel> movieGenres =
        GenreUtils.moviesGenreNames(moviesModel.genreIds);

    return Wrap(
      children: List.generate(
        movieGenres.length,
        (index) => chipWidget(
            genreName: movieGenres[index].name ?? '', context: context),
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
