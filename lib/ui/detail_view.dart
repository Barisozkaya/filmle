import 'package:filmle/model/movie.dart';
import 'package:filmle/ui/FavoritePage.dart';
import 'package:filmle/ui/youtube_video_player_view.dart';
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              movie.title.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FavoritePage(movie: movie),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: key != null &&
                              movie.id.toString() ==
                                  _youtubeVideoProvider.video!.id.toString()
                          ? YoutubeVideoPlayer(
                              videoKey: key,
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
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
            ),
          ],
        ),
      ),
    );
  }
}
