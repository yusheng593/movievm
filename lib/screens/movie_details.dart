import 'package:flutter/material.dart';
import 'package:movievm/constants/my_app_constants.dart';
import 'package:movievm/widgets/cached_image.dart';
import 'package:movievm/widgets/movies/favorite_btn.dart';
import 'package:movievm/widgets/movies/genres_list_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.45,
              width: double.infinity,
              child: const CachedImageWidget(imgUrl: MyAppConstants.movieImage),
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
                                  'Movie title',
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
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text("9/10"),
                                    Spacer(),
                                    Text(
                                      "Release Date",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const GenresListWidget(),
                                const SizedBox(height: 8),
                                Text(
                                  'overview, ' * 200,
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
                          child: const FavoriteBtnWidget(),
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
