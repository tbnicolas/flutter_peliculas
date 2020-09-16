import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });
    return new Container(
      height: _screenSize.height * 0.2,
      child: new PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return _tarjeta(context, peliculas[i]);
        },
        //children: _tarjetas(context),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-poster';
    final tarjeta = new Container(
      margin: EdgeInsets.only(right: 15.0),
      child: new Column(
        children: <Widget>[
          new Hero(
            tag: pelicula.uniqueId,
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: new FadeInImage(
                placeholder: new AssetImage('assets/img/no-image.jpg'),
                image: new NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
          ),
          //new SizedBox(height: 5.0,),
          new Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return new GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return new Container(
        margin: EdgeInsets.only(right: 15.0),
        child: new Column(
          children: <Widget>[
            new ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: new FadeInImage(
                placeholder: new AssetImage('assets/img/no-image.jpg'),
                image: new NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
            //new SizedBox(height: 5.0,),
            new Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
