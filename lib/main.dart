import 'package:flutter/material.dart';

import 'package:moviesapp/src/pages/home_page.dart';
import 'package:moviesapp/src/pages/detail_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mis películas',
        initialRoute: '/',
        routes: {
          '/' : (BuildContext context ) => HomePage(),
          'detail' : (BuildContext context ) => MovieDetail(),
        }
    );
  }
}