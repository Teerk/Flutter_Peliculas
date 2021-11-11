import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'ca7dd76f763b5ba8027a44af8f609acd';
  final String _lenguaje = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _paginaPopularPage = 0;

  Map<int, List<Cast>> moviesCast = {};


  MoviesProvider(){
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String segmento, [int pagina=1]) async {
    var url = Uri.https(_baseUrl, segmento,
        {'api_key': _apiKey, 'lenguage': _lenguaje, 'page': '$pagina'});

    final responde = await http.get(url);
    return responde.body;
  }

  getOnDisplayMovies() async{

    final jsonData = await _getJsonData('3/movie/now_playing');

      final nowPlayingResponse =  NowPlayingResponse.fromJson(jsonData);


      // final Map<String, dynamic> decodeData = json.decode(responde.body);
      
      // print(decodeData['dates']);

      print(nowPlayingResponse.results[1].title);
      onDisplayMovies = nowPlayingResponse.results;

      notifyListeners();
  }

  getPopularMovies() async{

    _paginaPopularPage++;

      final jsonData = await _getJsonData('3/movie/popular',_paginaPopularPage);
      final popularResponse =  PopularResponse.fromJson(jsonData);      
      popularMovies = [...popularMovies,...popularResponse.results];
      print(popularMovies[0]);
      notifyListeners();
  }

 Future<List<Cast>> getMovieCast(int movieId) async{

      //memoria
      if(moviesCast.containsKey(movieId))return moviesCast[movieId]!;

      final jsonData = await _getJsonData('3/movie/$movieId/credits');
      final creditsResponde = CreditsResponse.fromJson(jsonData);
      moviesCast[movieId] = creditsResponde.cast;
      return creditsResponde.cast;

  }

}