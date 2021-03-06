import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'hot_course_item.dart';
import '../common_widget/banner.dart';
import 'package:course_booking_app/provider/current_index_provider.dart';
import 'package:course_booking_app/utils/utils.dart';
import 'package:course_booking_app/style/index.dart';
import 'package:course_booking_app/model/course_model.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

const List menuData = [
  {"color": "#DF71F5", "title": "我的课表"},
  {"color": "#2283F6", "title": "课堂作业"},
  {"color": "#19AA8D", "title": "课堂考勤"},
  {"color": "#FE3D50", "title": "每日阅读"},
  {"color": "#FEA43D", "title": "我的成绩"},
  {"color": "#833DFE", "title": "课堂评价"},
];

class HomeState extends State<Home> {
  List<CourseModel> courseList;
  ScrollController controller = ScrollController();
  double barOpacity = 0.0;

  final double TOPBAR_HEIGHT = Gpadding.m + Gsize.statusBarHeight + 60;

  @override
  void initState() {
    super.initState();
    double opacity;
    controller.addListener(() {
      setState(() {
        opacity = controller.offset / TOPBAR_HEIGHT;
        if (opacity > 1) {
          barOpacity = 1;
        } else if (opacity < 0) {
          barOpacity = 0;
        }  else {
          barOpacity = opacity;
        }
      });
    });
    List<String> type = ["音乐", "语文", "美术", "数学"];
    courseList = List.generate(4, (index) => CourseModel.fromJson({
      "id": "$index",
      "image": "assets/images/courses/${index + 1}.png",
      "desc": "名师教学、保证高分、一对一辅导",
      "name": "${type[index]}趣味课堂",
    }));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // 首页菜单
  Widget renderMenuList() {
    double deviceWidth = MediaQuery.of(context).size.width;
    double itemWidth = (deviceWidth - 110) / 4;
    double itemHeight = itemWidth;
    double radiusSize = itemHeight / 2;

    return Container(
      margin: EdgeInsets.only(top: Gpadding.s),
      padding: EdgeInsets.symmetric(horizontal: Gpadding.m),
      height: itemHeight + 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: menuData.map((item) => GestureDetector(
            onTap: () {
            print(item["title"]);
          },
          child: Container(
            width: itemWidth,
            margin: EdgeInsets.only(left: Gpadding.s, right: Gpadding.s, bottom: Gpadding.l),
            child: Column(
              children: <Widget>[
                Container(
                  width: itemWidth,
                  height: itemHeight,
                  margin: EdgeInsets.only(bottom: Gpadding.xs),
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
                  style: TextStyle(fontSize: FontSize.s, color: FontColor.grey),
                )
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  // 热门课程
  Widget renderHotCourses(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Gpadding.m, right: Gpadding.m, bottom: Gpadding.xxl),
      padding: EdgeInsets.all(Gpadding.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Gradius.s),
        boxShadow: [
          Gshadow.black(0, 1, .05, 1, 0)
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    color: Colors.blue,
                    width: 6,
                    height: 20,
                    margin: EdgeInsets.only(right: Gpadding.s),
                  ),
                  Text(
                    '热门课程',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Consumer<CurrentIndexProvider> (
                builder: (context, indexProvider, _) {
                  return Container(
                    padding: EdgeInsets.only(right: Gpadding.s),
                    child: GestureDetector(
                      onTap: () {
                        indexProvider.changeIndex(1);
                      },
                      child: Text(
                        '查看更多 >',
                        style: TextStyle(fontSize: FontSize.s, color: Colors.blue),
                      ),
                    ) 
                  );
                },
              ),
            ],
          ),
          // 热门课程列表
          ...courseList.map((CourseModel item) => HotCourseItem(item)).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> bannerData = [
      'assets/images/banners/5.png',
      'assets/images/banners/1.jpeg',
      'assets/images/banners/2.jpeg',
      'assets/images/banners/3.jpeg',
      'assets/images/banners/4.jpeg',
    ];

    return Scaffold(
      // 使用SingleChildScrollView能够覆盖刘海区域,  ListView默认不会,可通过设置padding为0实现
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: controller,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 220 + Gsize.statusBarHeight,
                      padding: EdgeInsets.only(top: Gpadding.m + Gsize.statusBarHeight, left: Gpadding.m, right: Gpadding.m),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(37, 177, 135, 0.6),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/images/avatar.jpeg'),
                                radius: 30,
                              ),
                              Padding(padding: EdgeInsets.only(left: Gpadding.m)),
                              Text(
                                'Hi Pikachu',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: FontSize.xl,
                                  color: FontColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Flexible(child: Container()),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(Gpadding.m, Gpadding.m + 80 + Gsize.statusBarHeight, Gpadding.m, Gpadding.m),
                      child: MyBanner(bannerData),
                    ),
                  ],
                ),
                renderMenuList(),
                renderHotCourses(context),
              ],
            ),
          ),
          Opacity(
            opacity: barOpacity,
            child: Container(
              color: Color.fromRGBO(37, 177, 135, 1),
              padding: EdgeInsets.fromLTRB(Gpadding.m, Gsize.statusBarHeight + Gpadding.xs, Gpadding.m, Gpadding.xs),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpeg'),
                    radius: 20,
                  ),
                  Padding(padding: EdgeInsets.only(left: Gpadding.m)),
                  Text(
                    'Hi Pikachu',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: FontSize.l,
                      color: FontColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ), 
    );
  }
}
