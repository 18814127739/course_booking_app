import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:course_booking_app/router/application.dart';
import 'package:course_booking_app/style/index.dart';

class BottomBar extends StatelessWidget {
  String courseId;
  double coursePrice;
  double courseDailyPrice;

  BottomBar({this.courseId, this.coursePrice, this.courseDailyPrice});

  // 预约
  void bookCourse(context) {
    Application.router.navigateTo(context, '/', transition: TransitionType.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Positioned(
      bottom: 0,
      child: Container(
        width: deviceWidth,
        padding: EdgeInsets.fromLTRB(Gpadding.m, Gpadding.s, Gpadding.m, Gpadding.s),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            Gshadow.black(0, -1, 0.1, 2, 0)
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '¥${coursePrice}',
                  style: TextStyle(color: FontColor.red, fontSize: FontSize.xxl, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.only(right: Gpadding.xs)),
                Text(
                  '日常价: ¥${courseDailyPrice}',
                  style: TextStyle(color: Colors.black87, fontSize: FontSize.s),
                ),
              ],
            ),
            GestureDetector(
              onTap: () { bookCourse(context); },
              child: Container(
                padding: EdgeInsets.fromLTRB(Gpadding.l, Gpadding.xs, Gpadding.l, Gpadding.xs),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Gradius.base),
                ),
                child: Text(
                  '免费预约',
                  style: TextStyle(color: FontColor.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}