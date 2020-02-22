import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_booking_app/provider/large_image_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:course_booking_app/style/index.dart';

class LargeImage extends StatefulWidget {
  int index;
  LargeImage(this.index);

  @override
  LargeImageState createState() => LargeImageState();
}

class LargeImageState extends State<LargeImage> {
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
    List<String> images = Provider.of<LargeImageProvider>(context).images;

    return Scaffold(
      body: Container(
        width: Gsize.deviceWidth,
        height: Gsize.deviceHeight,
        color: Colors.black,
        child: InkWell(
          onTap: () { Navigator.pop(context);},
          child: Center(
            child: Swiper(
              itemCount: images.length,
              index: curIndex,
              onIndexChanged: (int index) {
                setState(() {
                  curIndex = index;
                });
              },
              itemBuilder: (BuildContext contetxt, int index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.contain,
                );
              },
              loop: false,
              autoplay: false,
            ),
          ),
        ),
      ),
    ); 
  }
}