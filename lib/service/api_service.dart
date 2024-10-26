import 'dart:convert';

import 'package:movievm/constants/api_constants.dart';
import 'package:movievm/constants/my_app_icons.dart';
import 'package:movievm/models/movies_genre.dart';
import 'package:movievm/models/movies_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/movie/popular?language=zh-tw&page=$page');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data);
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception(
          '${MyAppIcons.error} error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }

  Future<List<MoviesGenreModel>> fetchGenres() async {
    final url =
        Uri.parse('${ApiConstants.baseUrl}/genre/movie/list?language=zh-tw');
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log('data: $data);
      return List.from(
          data['genres'].map((element) => MoviesGenreModel.fromJson(element)));
    } else {
      throw Exception(
          '${MyAppIcons.error} error: ${ApiConstants.baseUrl} 錯誤 ${response.statusCode}');
    }
  }
}
