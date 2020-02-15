import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../provider/current_index_provider.dart';
import '../../utils/utils.dart';
import 'banner.dart';
import 'course_item.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  // 首页菜单
  Widget renderMenuList() {
    List menuData = [
      {"color": "#DF71F5", "title": "我的课表"},
      {"color": "#2283F6", "title": "课堂作业"},
      {"color": "#19AA8D", "title": "课堂考勤"},
      {"color": "#FE3D50", "title": "每日阅读"},
      {"color": "#FEA43D", "title": "我的成绩"},
      {"color": "#833DFE", "title": "课堂评价"},
    ];
    double deviceWidth = MediaQuery.of(context).size.width;
    double itemWidth = (deviceWidth - 120) / 4;
    double itemHeight = itemWidth;
    double radiusSize = itemHeight / 2;

    List<Widget> menuList = menuData.map((item) {
      return InkWell(
        onTap: () {
          print(item["title"]);
        },
        child: Container(
          width: itemWidth,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: itemWidth,
                height: itemHeight,
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: string2Color(item["color"]),
                    borderRadius: BorderRadius.all(Radius.circular(radiusSize))
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/dog.jpeg'),
                ),
              ),
              Text(
                item["title"],
                style: TextStyle(fontSize: 12, color: string2Color('#9E9EA3')),
              )
            ],
          ),
        ),
      );
    }).toList();

    return Center(
      child: Wrap(
        spacing: 4,
        children: menuList,
      ),
    );
  }

  // 热门课程
  Widget renderHotCourses(BuildContext context) {
    List courseData = [
      {
        "id": "1", 
        "name": '音乐趣味课堂', 
        "desc": "名师教学、保证高分、一对一辅导",
        "image": "assets/images/courses/1.png"
      },
      {
        "id": "2", 
        "name": '语文趣味课堂', 
        "desc": "名师教学、保证高分、一对一辅导",
        "image": "assets/images/courses/2.png"
      },
      {
        "id": "3", 
        "name": '美术趣味课堂', 
        "desc": "名师教学、保证高分、一对一辅导",
        "image": "assets/images/courses/3.png"
      },
      {
        "id": "4", 
        "name": '数学趣味课堂', 
        "desc": "名师教学、保证高分、一对一辅导",
        "image": "assets/images/courses/4.png"
      },
    ];

    List<Widget> courseList = courseData.map((item) => 
      CourseItem(item["id"], item["name"], item["desc"], item["image"])
    ).toList();

    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 40),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100], //阴影颜色
            blurRadius: 1.0, //模糊值
            spreadRadius: 1.0, //扩展阴影半径
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    color: string2Color('#2B88F4'),
                    width: 6,
                    height: 20,
                    margin: EdgeInsets.only(right: 10),
                  ),
                  Text(
                    '热门课程',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    // 切换至课程列表tab
                    Provider.of<CurrentIndexProvider>(context).changeIndex(1);
                  },
                  child: Text(
                    '查看更多 >',
                    style: TextStyle(fontSize: 12, color: string2Color('#2B88F4')),
                  ),
                ) 
              )
            ],
          ),
          ...courseList,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 220,
                    padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(37, 177, 135, 0.57),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar.jpeg'),
                              radius: 30,
                            ),
                            Padding(padding: EdgeInsets.only(left: 15)),
                            Text(
                              'Hi Pikachu',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Flexible(child: Container()),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 80)),
                    HomeBanner(),
                  ],
                ),
              ),
            ],
          ),
          renderMenuList(),
          renderHotCourses(context),
        ],
      ),
    );
  }
}
