import 'package:flutter/material.dart';

import 'package:moviesapp/src/widgets/card_swiper_widget.dart';
import 'package:moviesapp/src/providers/movies_providers.dart';
import 'package:moviesapp/src/widgets/movie_horizontal_widget.dart';


class HomePage extends StatelessWidget {
  @override

  final moviesProvider = new MoviesProvider();

  Widget build(BuildContext context) {
    moviesProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _swiperCards(),
                _footer(context)
              ],
            ),
          )
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
        future: moviesProvider.getNowCinemas(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData) {
            return CardSwiper(movies: snapshot.data);
          } else {
            return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(
                  child: CircularProgressIndicator()
                )
            );
          }
        }
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 4.0),

          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData) {
                return MovieHorizontal(
                    movies: snapshot.data,
                    nextPage: moviesProvider.getPopular
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })
        ],
      ),
    );
  }
}

