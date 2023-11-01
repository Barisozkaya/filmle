import 'dart:convert';
import 'package:filmle/core/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  var queryPram = {'api_key': 'ee10960583ebaa4f0cc8ddad15386ac5'};
  Future<List<Movie>?> loadMovies() async {
    var url =
        Uri.https('api.themoviedb.org', '/3/movie/now_playing', queryPram);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> list = body['results'];
      return list.map<Movie>((item) => Movie.fromJson(item)).toList();
    }
    return null;
  }
}
