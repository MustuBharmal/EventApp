import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  ImageSlider({Key? key}) : super(key: key);
  final List<String> imgList = [
    'https://firebasestorage.googleapis.com/v0/b/eventapp-1cc7e.appspot.com/o/5.jpg?alt=media&token=2e222f86-a5a1-4f1e-929e-2df24045fdd6',
    'https://firebasestorage.googleapis.com/v0/b/eventapp-1cc7e.appspot.com/o/Marketing-and-Selling.jpg?alt=media&token=0129ea39-30d8-44b3-a039-cc11aeef9c94',
    'https://firebasestorage.googleapis.com/v0/b/eventapp-1cc7e.appspot.com/o/Artist-For-College-Events.jpg?alt=media&token=533d646c-7d9b-41d1-8834-6e2e8a830fc8',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(4.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0.0,
                          ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1.5,
        viewportFraction: 1,
        enlargeCenterPage: true,
        // enlargeStrategy: CenterPageEnlargeStrategy.height,
        initialPage: 0,
        autoPlay: true,
      ),
      items: imageSliders,
    );
  }
}
