import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:course_booking_app/router/application.dart';
import 'package:course_booking_app/style/index.dart';
import 'package:course_booking_app/model/course_model.dart';

class CourseItem extends StatelessWidget {
  CourseModel course;
  
  CourseItem(@required this.course);

  void showMore() {
    print('${course.id} more');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Application.router.navigateTo(context, '/courseDetail?id=${course.id}', transition: TransitionType.fadeIn);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Gpadding.l),
        child: Row(
          children: <Widget>[
            Image.asset(
              course.image,
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
                    course.name,
                    maxLines: 1,
                    style: TextStyle(color: FontColor.black),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: Gpadding.xs)),
                  Text(
                    course.desc,
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
                        '${course.price}',
                        style: TextStyle(fontSize: FontSize.xl, color: FontColor.red),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: Gpadding.xs)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${course.bookNum}人已付款',
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
      ),
    );
  }
}