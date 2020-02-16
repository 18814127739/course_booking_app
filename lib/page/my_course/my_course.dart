import 'package:flutter/material.dart';
import '../../style/index.dart';
import '../../utils/utils.dart';
import 'my_course_item.dart';

class MyCourse extends StatefulWidget {
  @override
  MyCourseState createState() => MyCourseState();
}

class MyCourseState extends State<MyCourse> {
  List courseData = List.generate(6, (index) => ({
    "id": "$index", 
    "name": "美术趣味课堂", 
    "image": "assets/images/courses/1.png", 
    "total": 48, 
    "finish": 42, 
    "teacher": "李老师"
  }));

  @override
  Widget build(BuildContext context) {
    List<Widget> courseList = courseData.map((item) =>
      MyCourseItem(
        item["id"],
        item["name"],
        item["image"],
        item["total"],
        item["finish"],
        item["teacher"],
      )
    ).toList();

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('我的课程', style: TextStyle(fontSize: FontSize.xl, color: FontColor.appBar)),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.chevron_left),
          color: FontColor.appBar,
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(Gpadding.m, Gpadding.l, Gpadding.m, 0),
        color: Colors.white,
        child: ListView(
          children: courseList,
        ),
      ),
    );
  }
}