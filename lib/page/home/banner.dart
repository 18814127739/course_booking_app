import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeBanner extends StatelessWidget {
  List<String> imgs = [
    'assets/images/banners/5.png',
    'assets/images/banners/1.jpeg',
    'assets/images/banners/2.jpeg',
    'assets/images/banners/3.jpeg',
    'assets/images/banners/4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width / 2 * 0.9;

    return Container(
      width: width,
      height: height,
      child: Swiper(
        itemCount: imgs.length,
        itemBuilder: (BuildContext contetxt, int index) {
          return Image.asset(
            imgs[index],
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
        autoplay: true,
        duration: 2000,
      ),
    );
  }
}