import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/actores_model.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_peliculas/src/providers/pelicula_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          new SliverList(
              delegate: new SliverChildListDelegate([
            new SizedBox(
              height: 10.0,
            ),
            _posterTitulo(pelicula, context),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _crearCasting(pelicula),
          ])),
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    final textoAppbar = new Text(
      pelicula.title,
      style: new TextStyle(color: Colors.white, fontSize: 16.0),
      //overflow: TextOverflow.ellipsis
    );
    return new SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: new FlexibleSpaceBar(
        centerTitle: true,
        title: textoAppbar,
        background: new FadeInImage(
          placeholder: new AssetImage('assets/img/loading.gif'),
          image: new NetworkImage(pelicula.getBackgroundImg()),
          // fadeInDuration: new Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: new Row(
        children: <Widget>[
          new Hero(
            tag: pelicula.uniqueId,
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: new Image(
                image: new NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          new SizedBox(
            width: 20.0,
          ),
          new Flexible(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis),
              new Text(
                pelicula.originalTitle,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              new Row(
                children: <Widget>[
                  new Icon(Icons.star_border),
                  new Text(pelicula.voteAverage.toString(),style: Theme.of(context).textTheme.subhead),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: new Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return new FutureBuilder(
        future:peliProvider.getCast(pelicula.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          if(snapshot.hasData){
            return _crearActoresPageView(snapshot.data);
          }else{
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return new SizedBox(
      height: 200.0,
      child: new PageView.builder(
          pageSnapping: false,
          controller: new PageController(
            viewportFraction: 0.3,
            initialPage: 1
          ),
          itemCount: actores.length,
          itemBuilder: (context, i)=>
            _actorTarjeta(actores[i])
          ,
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new ClipRRect(
            borderRadius:BorderRadius.circular(20.0),
            child: new FadeInImage(
                placeholder: new AssetImage('assets/img/no-image.jpg'),
                image: new NetworkImage(actor.getFoto()),
                height: 150.0,
                fit: BoxFit.cover,
            ),
          ),
          new Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
