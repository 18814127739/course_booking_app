import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'course_item.dart';
import 'package:course_booking_app/utils/utils.dart';
import 'package:course_booking_app/style/index.dart';
import 'package:course_booking_app/model/course_model.dart';

class CourseList extends StatefulWidget {
  @override
  CourseListState createState() => CourseListState();
}

class CourseListState extends State<CourseList> with SingleTickerProviderStateMixin {
  List<CourseModel> courseList;
  // tab控制器
  TabController tabController;
  List<Map<String, dynamic>> tabs;
  bool tabVisible = true;

  @override
  void initState() {
    List<CourseModel> courseList = List.generate(5, (int index) => CourseModel.fromJson({
      "id": "$index", 
      "name": "寒假全期小/初/高数学辅导班", 
      "desc": "名师辅导 一对一教学", 
      "image": "assets/images/courses/${index + 1}.png", 
      "price": 59.00, 
      "bookNum": 100
    }));
    tabs = [
      { "value": "1", "label": "全部", "data": courseList},
      { "value": "2", "label": "推荐", "data": courseList},
      { "value": "3", "label": "热门", "data": courseList},
      { "value": "4", "label": "物理", "data": courseList},
      { "value": "5", "label": "数学", "data": courseList},
    ];
    tabController = TabController(length: tabs.length, vsync: this);
    // 注册监听事件
    tabController.addListener(() {
      var index = tabController.index;
      print("index: $index");
    });
    // 可通过tabController初始化tabindex
    // tabController.index = 1; 
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // 导航至搜索页
  void turnToSearch() {
    print('turn to searchPage');
  }

  void toggleTabVisible() {
    setState(() {
      tabVisible = !tabVisible;
    });
  }

  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1, // 阴影高度
      brightness: Brightness.light, //控制状态栏文字的颜色，lignt 文字是灰色的，dark是白色的
      automaticallyImplyLeading: false, // 去掉leading空间
      titleSpacing: 10, // title两边的空白区域
      title: GestureDetector(
        onTap: turnToSearch,
        child: Container(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: Gpadding.m),
          decoration: BoxDecoration(
            color: string2Color('#F7F7F7'),
            borderRadius: BorderRadius.all(Gradius.base),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '搜索课程',
                style: TextStyle(fontSize: FontSize.m, color: FontColor.grey),
              ),
              Icon(Icons.search, color: FontColor.grey),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Center(
          child: GestureDetector(
            onTap: toggleTabVisible,
            child: Container(
              height: 30,
              width: 60,
              margin: EdgeInsets.only(right: Gpadding.m, left: Gpadding.m),
              decoration: BoxDecoration(
                color: string2Color('#F7F7F7'),
                borderRadius: BorderRadius.all(Gradius.base),
              ),
              child: Center(
                child: Text(
                  '分类',
                  style: TextStyle(
                    color: FontColor.grey,
                  ),
                ),
              ),
            ),
          ), 
        )
      ],
      // 根据tabVisible 显示/隐藏 选项卡
      bottom: tabVisible ? TabBar(
          // 设置tab控制器
          controller: tabController, 
          isScrollable: true,
          // onTap: changeIndex,
          // indicatorColor: Colors.blue, // 指示器颜色
          labelColor: Colors.blue, // 选中文字颜色
          unselectedLabelColor: string2Color('#44444F'), // 未选中文字颜色
          tabs: tabs.map((item) => Tab(text: item["label"])).toList(),
        ) : null,
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> renderCourseList(List<CourseModel> courseList) {
      return courseList.map((CourseModel c) => 
        CourseItem(c)
      ).toList();
    }

    // 使用DefaultTabController关联TabBar及TabBarView
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: renderAppBar(),
        //添加选项卡视图
        body: TabBarView(
           // 设置tab控制器, 和TabBar使用同一个tabController
          controller: tabController,
          //迭代显示选项卡视图
          children: tabs.map((Map<String, dynamic> item) =>
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(Gpadding.m, Gpadding.m, Gpadding.m, 0),
              child: ListView(
                children: renderCourseList(item["data"]),
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
