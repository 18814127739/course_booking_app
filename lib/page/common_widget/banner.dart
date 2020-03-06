import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyBanner extends StatelessWidget {
  List<String> imgs = [];

  MyBanner(this.imgs);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width / 2;

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