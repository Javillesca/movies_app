import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moviesapp/src/models/movie_model.dart';

class MoviesProvider {
  String _apikey = '8e4fe5dd406998c4ff2e53688d4c3465';
  String _url    = 'api.themoviedb.org';
  String _language = 'es-ES';
  
  Future<List<Movie>>getNowCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language
    });

  final resp = await http.get(url);
  final decodedData = json.decode(resp.body);
  final movies = new Movies.fromJsonList(decodedData['results']);

  return movies.items;
  }


}