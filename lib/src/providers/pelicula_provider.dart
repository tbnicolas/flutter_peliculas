import 'dart:async';
import 'dart:convert';
import 'package:flutter_peliculas/src/models/actores_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_peliculas/src/models/pelicula_model.dart';


class PeliculasProvider{

  String _apiKey='70ac6c18a864caa6c8d2940761abdbed';
  String _url = 'api.themoviedb.org';
  String _lenguage ='es-ES';
  int _popularesPage =0;
  bool _cargando = false;
  
  List<Pelicula> _populares = new List();
  final _popularesStreamController = new StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }


  Future<List<Pelicula>>_procesarRespuesta(Uri url) async{
    final resp= await http.get(url);
    final decodedData = json.decode(resp.body);
    final pelicula = new Peliculas.fromJsonList(decodedData['results']);
    //print(pelicula.items[10].title);
    return pelicula.items;
  }

  Future<List<Pelicula>>getEnCines()async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key':_apiKey,
      'language':_lenguage,
    });
      return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>>getPopulares()async{
    if(_cargando)return[];
    _cargando=true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key':_apiKey,
      'language':_lenguage,
      'page': _popularesPage.toString()
    });

    final res = await _procesarRespuesta(url);
    _populares.addAll(res);
    popularesSink(_populares);
    _cargando=false;
    return res;

  }

  Future<List<Actor>>getCast(String peliId) async{
      final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key':_apiKey,
      'language':_lenguage,
      });
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final cast = new Cast.fromJsonList(decodedData['cast']);
      return cast.actores;
  }
  Future<List<Pelicula>>buscarPelicula(String query)async{
    final url = Uri.https(_url, '3/search/movie',{
      'api_key':_apiKey,
      'language':_lenguage,
      'query':query
    });
    return await _procesarRespuesta(url);
  }
}