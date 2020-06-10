import 'package:flutter/material.dart';
import 'package:moviesapp/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
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
    return CardSwiper(
      movies: [1,2,3,4],
    );
  }
}
