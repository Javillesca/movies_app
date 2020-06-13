import 'package:flutter/material.dart';

import 'package:moviesapp/src/models/actors_model.dart';
import 'package:moviesapp/src/models/movie_model.dart';
import 'package:moviesapp/src/providers/movies_providers.dart';

class MovieDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppbar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _posterTitle(context, movie),
                _description(movie),
                _createCasting(movie),
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _createAppbar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
            movie.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0)
        ),
        background: FadeInImage(
            image: NetworkImage(movie.getBackgroundImg()),
            placeholder: AssetImage('assets/images/loading.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover
        )
      )
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                  child: Image(
                    image: NetworkImage(movie.getPosterImg()),
                    height: 150.0,
                  )
              )
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
          movie.overview,
          textAlign: TextAlign.justify),
    );
  }

  Widget _createCasting(Movie movie) {
    final movieProvider = new MoviesProvider();
    
    return FutureBuilder(
        future: movieProvider.getCast(movie.uniqueId.toString()),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData) {

            return _createActorPageView(snapshot.data);
          } else {
            return Center(child:  CircularProgressIndicator());
          }
        }
    );
  }

  Widget _createActorPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1
          ),
          itemBuilder: (context, i) => _actorCard(actors[i]),
          itemCount: actors.length
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getActorImg()),
              placeholder: AssetImage('assets/images/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover
            )
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
