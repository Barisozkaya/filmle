import 'package:filmle/core/model/cast_response.dart';
import 'package:filmle/core/repository/movie_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:rxdart/subjects.dart';

class CastsBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<CastResponse> _subject =
      BehaviorSubject<CastResponse>();

  getCasts(int id) async {
    CastResponse response = await _repository.getCasts(id);
    _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<CastResponse> get subject => _subject;
}

final castsBloc = CastsBloc();
