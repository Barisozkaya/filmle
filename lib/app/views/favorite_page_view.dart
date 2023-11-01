import 'package:filmle/core/model/movie.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  Movie movie;
  FavoritePage({Key? key, required this.movie}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Movie> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    favoriteMovies.add(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoriye Ekle"),
      ),
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          Movie favoriteMovie = favoriteMovies[index];
          return ListTile(
            title: Text(favoriteMovie.title!),
            subtitle: Text(favoriteMovie.releaseDate!),
          );
        },
      ),
    );
  }
}
