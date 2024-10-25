import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/constants/api_constants.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:movievm/widgets/cached_image.dart';
import 'package:movievm/widgets/movies/favorite_btn.dart';
import 'package:movievm/widgets/movies/genres_list_widget.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({super.key, required this.movieModel});
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 只是為了使用currentMovie = Provider.family，否則應該傳資料進來就好
    // final movieModel = ref.watch(currentMovie(index));
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: movieModel.id,
              child: SizedBox(
                height: size.height * 0.45,
                width: double.infinity,
                child: CachedImageWidget(
                    imgUrl: ApiConstants.postUrl + movieModel.posterPath),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieModel.title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                        '${movieModel.formattedVoteAverage}/10'),
                                    const Spacer(),
                                    Text(
                                      movieModel.releaseDate,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                GenresListWidget(movieModel),
                                const SizedBox(height: 8),
                                Text(
                                  movieModel.overview,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(20)),
                          width: 100,
                          child: FavoriteBtnWidget(
                            movieModel: movieModel,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor, shape: BoxShape.circle),
                child: const BackButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
