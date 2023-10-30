import 'package:filmle/model/movie.dart';
import 'package:filmle/viewmodel/youtube_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatelessWidget {
  Movie movie;
  late YoutubeVideoProvider _youtubeVideoProvider;
  DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _youtubeVideoProvider =
        Provider.of<YoutubeVideoProvider>(context, listen: true);

    _youtubeVideoProvider.id = movie.id.toString();
    _youtubeVideoProvider.loadVideo();

    String? key;
    if (_youtubeVideoProvider.video == null ||
        _youtubeVideoProvider.video!.results![0].key!.isEmpty) {
      key = null;
    } else {
      key = _youtubeVideoProvider.video!.results![0].key;
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            key != null &&
                    movie.id.toString() ==
                        _youtubeVideoProvider.video!.id.toString()
                ? YoutubeVideoPlayer(
                    videoKey: key,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: size.width * 0.6,
                              child: Text(
                                movie.title.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Row(
                            children: [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.white70,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                      child: Text(
                        movie.overview!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class YoutubeVideoPlayer extends StatefulWidget {
  YoutubeVideoPlayer({required this.videoKey, super.key});
  late String videoKey;

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayer(
        controller: _controller,
      ),
    );
  }
}
