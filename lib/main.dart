import'package:flutter/material.dart';
import 'package:flutter_peliculas/src/pages/home_page.dart';
import 'package:flutter_peliculas/src/pages/pelicula_detalle.dart';
void main()=>runApp(new MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Peliculas',
      initialRoute: '/',
      routes: {
         '/': (BuildContext context)=> new HomePage(),
         'detalle': (BuildContext context)=> new PeliculaDetalle(),
      },
      
    );
  }
}

