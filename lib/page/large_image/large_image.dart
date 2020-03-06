import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_booking_app/provider/large_image_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LargeImage extends StatefulWidget {
  int index;
  String id;
  LargeImage(this.index, this.id);

  @override
  LargeImageState createState() => LargeImageState();
}

class LargeImageState extends State<LargeImage> {
  int curIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      curIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () { Navigator.pop(context);},
        child: Hero(
          tag: '${widget.id}-${curIndex}',
          child: Center(
            child: Consumer<LargeImageProvider> (
              builder: (context, largeImageProvider, _) {
                List<String> images = largeImageProvider.images;
                return Swiper(
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
                );
              },
            ),
          ),
        ),
      ),
    ); 
  }
}