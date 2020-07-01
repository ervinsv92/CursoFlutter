import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  //const MovieHorizontal({Key key}) : super(key: key);

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageControler = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    //Para validar que se llegó a la última película
    _pageControler.addListener(() {
        if(_pageControler.position.pixels >= _pageControler.position.maxScrollExtent -200 ){
          siguientePagina();
        }
    });

    return Container(
      height: _screenSize.height *0.2,
      child: PageView.builder( //PageView sin bulder renderisa todo desde 0, con el builder solo lo hace con los nuevos datos, lo hace bajo demanda
        pageSnapping: false,
        controller: _pageControler,
        //children: _tarjetas(context), //Se usa con el PageView sin builder
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i])
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = '${ pelicula.id }-poster';

    final tarjeta = Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              Hero(
                tag: pelicula.uniqueId,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 80.0,
                ),
              ),
              ),
              SizedBox(height: 5.0,),
              Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        );

        return GestureDetector(
          child: tarjeta,
          onTap: (){
            Navigator.pushNamed(context, 'detalle', arguments: pelicula);
          },
        );
  }


  //Se usaba con el PageView sin builder
  List<Widget> _tarjetas(BuildContext context){
    return peliculas.map((pelicula){
        return Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                    height: 80.0,
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        );
    }).toList();
  }
}