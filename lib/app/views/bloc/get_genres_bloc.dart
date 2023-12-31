import 'package:filmle/core/model/genre_response.dart';
import 'package:filmle/core/repository/movie_repository.dart';
import 'package:rxdart/subjects.dart';

class GenresBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await _repository.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

final genresBloc = GenresBloc();
