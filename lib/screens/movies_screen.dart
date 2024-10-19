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

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final List<MovieModel> _movies = [];
  int _currentPage = 1;
  bool _isFetching = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetching) {
      _fetchMovies();
    }
  }

  _fetchMovies() async {
    if (_isFetching) {
      return;
    }
    setState(() {
      _isFetching = true;
    });
    try {
      final List<MovieModel> moviews =
          await getIt<MoviesRepository>().fetchMovies(page: _currentPage);
      setState(() {
        _movies.addAll(moviews);
        _currentPage++;
      });
    } catch (e) {
      getIt<NavigationService>().showSnackbar('$e');
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

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
          controller: _scrollController,
          itemCount: _movies.length + (_isFetching ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _movies.length) {
              return MoviesWidget(
                movieModel: _movies[index],
              );
            } else {
              return const CircularProgressIndicator.adaptive();
            }
          }),
    );
  }
}
