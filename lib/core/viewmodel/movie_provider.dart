import 'package:filmle/core/repository/movie_repository.dart';
import 'package:flutter/material.dart';
import '../model/movie.dart';

class MovieProvider extends ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();
  List<Movie>? _movies = [];
  List<Movie>? get movies => _movies;

  loadMovies() async {
    List<Movie>? listMovies = await _movieRepository.loadMovies();
    _movies = listMovies;
    notifyListeners();
  }
}
