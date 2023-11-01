import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LoadingCarouselSlider extends StatelessWidget {
  const LoadingCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: 380.0,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
      ),
      items: [0, 0, 0].map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(16.0)),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
