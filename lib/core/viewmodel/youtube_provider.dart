import 'package:filmle/core/repository/youtube_video.dart';
import 'package:flutter/material.dart';
import '../model/video.dart';

class YoutubeVideoProvider extends ChangeNotifier {
  final YoutubeVideoRepository _youtubeVideoRepository =
      YoutubeVideoRepository();
  Video? _video;
  Video? get video => _video;

  String _id = '';
  String get id => _id;
  set id(String id) => _id = id;

  Future loadVideo() async {
    _video = await _youtubeVideoRepository.loadVideo(id);
    notifyListeners();
  }
}
