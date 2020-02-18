import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BigImage extends StatefulWidget {
  List<String> imgs = [];
  int index = 0;

  BigImage(this.imgs, this.index);

  @override
  BigImageState createState() => BigImageState();
}

class BigImageState extends State<BigImage> {
  int curIndex;

  @override
  void initState() {
    setState(() {
      curIndex = widget.index;
    });
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
      return Center(
        child: Swiper(
          itemCount: widget.imgs.length,
          index: curIndex,
          onIndexChanged: (int index) {
            setState(() {
              curIndex = index;
            });
          },
          itemBuilder: (BuildContext contetxt, int index) {
            return Image.asset(
              widget.imgs[index],
              fit: BoxFit.contain,
            );
          },
          autoplay: false,
        ),
      );
    }
}