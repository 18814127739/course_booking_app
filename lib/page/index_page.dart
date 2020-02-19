import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_booking_app/provider/current_index_provider.dart';
import 'home/home.dart';
import 'course_list/course_list.dart';
import 'me/me.dart';

class IndexPage extends StatefulWidget {
  @override
  IndexPageState createState() => IndexPageState();
}

const List tabs = [
  {
    'title': '首页',
    'icon': Icon(Icons.home),
  },
  {
    'title': '课程',
    'icon': Icon(Icons.bookmark),
  },
  {
    'title': '我的',
    'icon': Icon(Icons.account_circle),
  },
];

class IndexPageState extends State<IndexPage> {
  Home home; // 首页
  CourseList courseList; // 课程页
  Me me; // 我的页

  currentPage() {
    int index = Provider.of<CurrentIndexProvider>(context).curIndex;
    switch(index) {
      case 0:
        if(home == null) {
          home = Home();
        }
        return home;
      case 1:
        if(courseList == null) {
          courseList = CourseList();
        }
        return courseList;
      case 2:
        if(me == null) {
          me = Me();
        }
        return me;
    }
  }

  @override
  Widget build(BuildContext context) {
    int curIndex = Provider.of<CurrentIndexProvider>(context).curIndex;

    return Scaffold(
      body: currentPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          Provider.of<CurrentIndexProvider>(context).changeIndex(index);
        },
        currentIndex: curIndex,
        items: tabs.map((item) => 
          BottomNavigationBarItem(
            icon: item['icon'],
            title: Text(item['title'])
          )
        ).toList(),
      ),
    );
  }
}