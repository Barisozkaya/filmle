import 'package:filmle/core/model/movie_response.dart';
import 'package:filmle/core/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _repository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesBloc = MoviesListBloc();
