import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/providers/pelicula_provider.dart';
import 'package:flutter_peliculas/src/search/search_delegate.dart';
import 'package:flutter_peliculas/src/widgets/card_swiper_widget.dart';
import 'package:flutter_peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Peliculas en cine'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search), onPressed: () {
            showSearch(
                context: context,
                delegate: new DataSearch(),
                //query: 'Hola Mundo'
            );
          }),
        ],
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return new FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return new CardSwiper(
              peliculas: snapshot.data,
            );
          } else {
            return Container(
              height:400.0 ,
                child: new Center(
                    child: new CircularProgressIndicator()
                )
            );
          }
        });
    /*;
    return new CardSwiper(
        peliculas: [1,2,3,4,5]
    );*/
  }

 Widget _footer(BuildContext context) {
    //peliculasProvider.getPopulares().then((data)=>print(data[0].popularity));
    return new Container(
      width: double.infinity,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 20.0),
            child: new Text('Populares',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
             new SizedBox(height: 5.0,),
             new StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return new MovieHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina:peliculasProvider.getPopulares,
                  );
                }else{
                   return new Center(child: new CircularProgressIndicator());
                }

              }
          )
        ],
      ),
    );
 }
}
