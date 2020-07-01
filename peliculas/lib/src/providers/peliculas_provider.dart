
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';
import 'dart:convert';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/video_model.dart';

class PeliculasProvider{
  String _apiKey = 'c22b82a36dcf8cdc84e5c80e1617a55e';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  //Se coloca el broadcast para que varios lugares puedan escuchar el stream, por defecto solo se puede conectar una vez
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  //Agrega peliculas al stream
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  //sirve para escuchar el stream
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();//cierra el stream sino es null
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async{
    
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apiKey,
      'languaje'  : _languaje
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async{

    //Se hace para que no tome parte del final del scroll y llame varias veces la misma petición
    if(_cargando) return [];

    _cargando=true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apiKey,
      'languaje'  : _languaje,
      'page'      : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;

    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'   : _apiKey,
      'languaje'  : _languaje,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }

  Future<List<Video>> getVideos(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/videos', {
      'api_key'   : _apiKey,
      'languaje'  : _languaje,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final videos = new Videos.fromJsonList(decodedData['results']);
    return videos.videos;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async{
    
    final url = Uri.https(_url, '3/search/movie', {
      'api_key'   : _apiKey,
      'languaje'  : _languaje,
      'query'     : query
    });

    return await _procesarRespuesta(url);
  }
}