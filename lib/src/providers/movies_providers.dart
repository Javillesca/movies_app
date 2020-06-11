import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:moviesapp/src/models/movie_model.dart';

class MoviesProvider {
  String _apikey = '8e4fe5dd406998c4ff2e53688d4c3465';
  String _url    = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _popular = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStream() {
    _popularStreamController?.close();
  }


  Future<List<Movie>> _populaResult(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
  
  Future<List<Movie>>getNowCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language
    });
    return await _populaResult(url);
  }

  Future<List<Movie>>getPopular() async {
    if(_loading) return [];
    _loading = true;
    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language': _language,
      'page'    : _popularPage.toString()
    });
    final resp = await _populaResult(url);
    _popular.addAll(resp);
    popularSink(_popular);
    _loading = false;

    return resp;

  }




}