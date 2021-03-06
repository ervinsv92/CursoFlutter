import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/video_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula),
                _crearVideos(pelicula),
              ]
            ),
          )
        ],
      ),  
    );
  }

  Widget _crearAppBar(Pelicula pelicula){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color:Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(//sirve para bordes redondeados
              borderRadius: BorderRadius.circular(20.0),
                child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1)
                ],)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula){
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        
        if(snapshot.hasData){
          return _crearActoresPageView(snapshot.data);
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearVideos(Pelicula pelicula){
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getVideos(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
        
        if(snapshot.hasData){
          return _crearVideosPageView(snapshot.data);
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller:  PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i])
      ),
    );
  }

  Widget _crearVideosPageView(List<Video> videos){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller:  PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: videos.length,
        itemBuilder: (context, i) => _videoTarjeta(videos[i])
      ),
    );
  }

  Widget _actorTarjeta(Actor actor){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                image: NetworkImage(actor.getFoto()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            )
      ],),
    );
  }

  _videoTarjeta(Video video){
    return Container(
          child: Column(
            children: <Widget>[
              GestureDetector(
                  onTap: (){
                    _playYoutubeVideo(video);
                  },
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                    child: Image(image: AssetImage('assets/img/youtube-play.png'))
                ),
              ),
              Text(
                video.name,
                overflow: TextOverflow.ellipsis,
                )
          ],),
        );
  }

  _playYoutubeVideo(Video video) {
    FlutterYoutube.playYoutubeVideoById(
      apiKey: "<API_KEY>",
      videoId: video.key,
      autoPlay: true
      //videoUrl: "https://www.youtube.com/watch?v=wgTBLj7rMPM",
    );
  }
}