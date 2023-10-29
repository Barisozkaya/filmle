import 'dart:convert';
import 'package:filmle/model/movie.dart';
import 'package:http/http.dart' as http;

class SearchRepository {
  final String apiKey = 'ee10960583ebaa4f0cc8ddad15386ac5';
  Future<List<Movie>?> loadSearch(String query) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> list = body['results'];
      return list.map<Movie>((item) => Movie.fromJson(item)).toList();
    }
    return null;
  }
}
