import 'package:flutter/material.dart';
import 'package:moviesapp/src/widgets/card_swiper_widget.dart';

import 'package:moviesapp/src/providers/movies_providers.dart';


class HomePage extends StatelessWidget {
  @override

  final moviesProvider = new MoviesProvider();

  Widget build(BuildContext context) {
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
              children: <Widget>[
                _swiperCards()
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
}
