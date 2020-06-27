
import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{
  String _apiKey = 'c22b82a36dcf8cdc84e5c80e1617a55e';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';
  int _popularesPage = 0;

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

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apiKey,
      'languaje'  : _languaje,
      'page'      : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    return resp;
  }
}