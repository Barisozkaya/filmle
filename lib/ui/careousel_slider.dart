import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmle/ui/detail_view.dart';
import 'package:filmle/viewmodel/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieCarouselSlider extends StatelessWidget {
  MovieCarouselSlider({Key? key}) : super(key: key);
  late MovieProvider _movieProvider;
  // late DotsIndicatorProvider _dotsIndicatorProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.5,
        viewportFraction: 0.60,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
      ),
      items: _movieProvider.movies!.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              movie: item,
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  item.postUrl,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
