import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:course_booking_app/style/index.dart';
import 'package:course_booking_app/router/application.dart';
import 'package:course_booking_app/page/common_widget/base_layout.dart';
import 'my_course_item.dart';
import 'package:course_booking_app/model/my_course_model.dart';

class MyCourse extends StatefulWidget {
  @override
  MyCourseState createState() => MyCourseState();
}

class MyCourseState extends State<MyCourse> {
  List<MyCourseModel> courseData = List.generate(6, (int index) => MyCourseModel.fromJson({
    "id": "$index", 
    "name": "美术趣味课堂", 
    "image": "assets/images/courses/1.png", 
    "total": 48, 
    "finish": 42, 
    "teacher": "李老师"
  }));

  @override
  Widget build(BuildContext context) {
    List<Widget> courseList = courseData.map((MyCourseModel item) =>
      GestureDetector(
        onTap: () {
          Application.router.navigateTo(
            context, '/myCourseDetail?id=${item.id}', transition: TransitionType.inFromRight,
          );
        },
        child: MyCourseItem(
          key: UniqueKey(),
          data: item,
        ),
      )
    ).toList();

    return BaseLayout(
      title: '我的课程',
      child: Container(
        padding: EdgeInsets.only(top: Gpadding.l),
        color: Colors.white,
        child: ListView(
          children: courseList,
        ),
      ),
    );
  }
}