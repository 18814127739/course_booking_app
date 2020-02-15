import 'package:flutter/material.dart';
import '../../style/index.dart';

class CourseItem extends StatelessWidget {
  String id;
  String name;
  String desc;
  String image;
  double price;
  int bookNum = 0;

  CourseItem(
    @required this.id,
    @required this.name,
    @required this.desc,
    @required this.image,
    @required this.price,
    @required this.bookNum
  );

  void showMore() {
    print('$id more');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Gpadding.l),
      child: Row(
        children: <Widget>[
          Image.asset(
            image,
            width: 98,
            height: 98,
            fit: BoxFit.cover,
          ),
          Padding(padding: EdgeInsets.only(right: Gpadding.m)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  maxLines: 1,
                  style: TextStyle(color: FontColor.black),
                ),
                Padding(padding: EdgeInsets.only(bottom: Gpadding.xs)),
                Text(
                  desc,
                  maxLines: 1,
                  style: TextStyle(fontSize: FontSize.s, color: FontColor.grey),
                ),
                Padding(padding: EdgeInsets.only(bottom: Gpadding.xs)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '¥',
                      style: TextStyle(fontSize: FontSize.s, color: FontColor.red),
                    ),
                    Text(
                      '$price',
                      style: TextStyle(fontSize: FontSize.xl, color: FontColor.red),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: Gpadding.xs)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${bookNum}人已付款',
                      style: TextStyle(fontSize: FontSize.s, color: FontColor.grey),
                    ),
                    GestureDetector(
                      onTap: showMore,
                      child: Icon(
                        Icons.more_horiz, 
                        color: FontColor.grey, 
                        size: 16
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}