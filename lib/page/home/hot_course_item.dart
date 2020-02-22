import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:course_booking_app/router/application.dart';
import 'package:course_booking_app/style/index.dart';
import 'package:course_booking_app/model/course_model.dart';

class HotCourseItem extends StatelessWidget {
  CourseModel course;

  HotCourseItem(@required this.course);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        // 可以传入多个形成组合阴影效果
        color: Colors.white,
        boxShadow: [
          Gshadow.black(0, 2, .12, 2, 0),
        ],
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            course.image,
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
                  course.name,
                  maxLines: 1,
                  style: TextStyle(fontSize: FontSize.l),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text(
                  course.desc,
                  maxLines: 2,
                  style: TextStyle(color: FontColor.grey),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () { 
                        Application.router.navigateTo(context, '/courseDetail?id=${course.id}', transition: TransitionType.fadeIn);
                      },
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