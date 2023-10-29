import 'dart:convert';
import '../model/video.dart';
import 'package:http/http.dart' as http;

class YoutubeVideoRepository {
  final String apiKey = 'ee10960583ebaa4f0cc8ddad15386ac5';

  Future<Video?> loadVideo(String id) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return Video.fromJson(body);
    }
    return null;
  }
}
