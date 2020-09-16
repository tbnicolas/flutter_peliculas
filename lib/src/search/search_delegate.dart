import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_peliculas/src/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate{
String seleccion = '';
final peliculasProvider = new PeliculasProvider();
final peliculas = [
  'Síderman',
  'Aquaman',
  'Shazam',
  'Batman',
  'Superman',
  'Avengers',
  'Joker',
  'Ironman',
  'Ironman2',
];

final peliculasRecientes = [
  'Spiderman',
  'Capitan America'
];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro Appbar( Ejmplo poder limpiarlo o cancelar la busqueda)
    return [
      new IconButton(
          icon: new Icon(Icons.clear),
          onPressed: (){
            query='';
          }
          ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Es un Widget que aparece al izquierda del Appbar (Ejemplo: el icono de esta pagina)
    return new IconButton(
        icon: new AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    if(query.isEmpty){
      return new Container();
    }
    return new FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
          if(snapshot.hasData){
            final peliculas = snapshot.data;
            return new ListView(
              children: peliculas.map((pelicula){
                return new ListTile(
                  leading: new FadeInImage(
                    placeholder: new AssetImage('assets/img/no-image.jpg'),
                    image: new NetworkImage(pelicula.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: new Text(pelicula.title),
                  subtitle: new Text(pelicula.originalTitle),
                  onTap: (){
                    close(context, null);
                    pelicula.uniqueId='';
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }).toList(),
            );
          }else{
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    /*final listaSugerida = (query.isEmpty)
                           ? peliculasRecientes
                           : peliculas.where(
                             (p)=>p.toLowerCase().startsWith(query.toLowerCase())
                              ).toList();
    return new ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (contex, i){
           return new ListTile(
             leading: new Icon(Icons.movie),
             title:  new Text(listaSugerida[i]),
             onTap: (){
               seleccion = listaSugerida[i];
               showResults(context);
             },
           );
        }
    );*/
    if(query.isEmpty){
      return new Container();
    }
    return new FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
          if(snapshot.hasData){
            final peliculas = snapshot.data;
            return new ListView(
              children: peliculas.map((pelicula){
                return new ListTile(
                  leading: new FadeInImage(
                      placeholder: new AssetImage('assets/img/no-image.jpg'),
                      image: new NetworkImage(pelicula.getPosterImg()),
                      width: 50.0,
                      fit: BoxFit.contain,
                  ),
                  title: new Text(pelicula.title),
                  subtitle: new Text(pelicula.originalTitle),
                  onTap: (){
                    close(context, null);
                    pelicula.uniqueId='';
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }).toList(),
            );
          }else{
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        }
    );
  }

}