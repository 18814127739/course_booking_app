import 'package:flutter/material.dart';
import '../../style/index.dart';

class HotCourseItem extends StatelessWidget {
  String id;
  String name;
  String desc;
  String image;

  HotCourseItem(@required this.id, @required this.name, @required this.desc, @required this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        // 可以传入多个形成组合阴影效果
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300], //阴影颜色
            blurRadius: 1.0, //模糊值
            spreadRadius: 1.5, //扩展阴影半径
            offset: Offset(0, 2.0), //x/y方向偏移量
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            image,
            width: 98,
            height: 98,
            fit: BoxFit.cover,
          ),
          Padding(padding: EdgeInsets.only(right: Gpadding.l)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  maxLines: 1,
                  style: TextStyle(fontSize: FontSize.l),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text(
                  desc,
                  maxLines: 2,
                  style: TextStyle(color: FontColor.grey),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () { print(name); },
                      child: Text(
                        '了解更多 >',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: FontSize.s, color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}