import 'package:flutter/material.dart';

import 'package:moviesapp/src/models/movie_model.dart';
import 'package:moviesapp/src/providers/movies_providers.dart';

class DataSearch extends SearchDelegate {

  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones disponibles en AppBar
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono de detalles
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder resultado
    return Container();
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty) return Container();

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if(snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
            children: movies.map((m) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(m.getPosterImg()),
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(m.title),
                subtitle: Text(m.originalTitle),
                onTap: () {
                  close(context, null);
                  m.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: m);
                },
              );
            }).toList()
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  /*@override
  Widget buildSuggestions(BuildContext context) {
    // Generador de suggestions
    final suggestionList = (query.isEmpty)
                            ? recentMovies
                            : movies.where(
                              (element) => element.toLowerCase().startsWith(query.toLowerCase())
                            ).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(suggestionList[i]),
            onTap: () {},
          );
        }
    );
    throw UnimplementedError();
  }*/

}