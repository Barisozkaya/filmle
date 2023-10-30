import 'package:filmle/repository/trending_repository.dart';
import 'package:flutter/material.dart';
import '../model/movie.dart';

class TrendingProvider extends ChangeNotifier {
  final TrendingRepository _trendingRepository = TrendingRepository();
  List<Movie>? _movies = [];
  List<Movie>? get movies => _movies;

  loadMovies() async {
    List<Movie>? listMovies = await _trendingRepository.loadMovies();
    _movies = listMovies;
    notifyListeners();
  }
}
