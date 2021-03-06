import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:course_booking_app/router/application.dart';
import 'package:course_booking_app/style/index.dart';
import 'package:course_booking_app/utils/utils.dart';
import 'profile_dialog.dart';

class Me extends StatefulWidget {
  @override
  MeState createState() => MeState();
}

class MeState extends State<Me> {
  final List menuData = [
    {"title": "我的课程", "icon": "assets/icons/me/course.png", "url": "myCourse"},
    {"title": "个人信息", "icon": "assets/icons/me/profile.png", "url": null},
    {"title": "课堂情况", "icon": "assets/icons/me/situation.png", "url": null},
    {"title": "成长记录", "icon": "assets/icons/me/grow.png", "url": null},
    {"title": "我的评价", "icon": "assets/icons/me/comment.png", "url": null},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onClickMenuItem(Map<String, String> item) {
    if(item["url"] != null) {
      Application.router.navigateTo(context, item["url"], transition: TransitionType.fadeIn);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${item["title"]}尚未开发'
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // 我的资料卡弹层
  void showProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ProfileDialog();
      },
    );
  }

  // 等级区域
  Widget renderLevel() {
    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(70, 130, 70, 0),
      padding: EdgeInsets.fromLTRB(Gpadding.s, Gpadding.s, Gpadding.s, Gpadding.s),
      decoration: BoxDecoration(
        color: string2Color('#25B187'),
        borderRadius: BorderRadius.only(topLeft: Gradius.s, topRight: Gradius.s),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '等级 Lv0',
            style: TextStyle(fontSize: FontSize.s, color: FontColor.white),
          ),
          Row(
            children: <Widget>[
              Text(
                '我的积分 1000',
                style: TextStyle(fontSize: FontSize.s, color: FontColor.white),
              ),
              Padding(padding: EdgeInsets.only(right: Gpadding.xs)),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: string2Color('#4C4C4C')),
                  borderRadius: BorderRadius.all(Gradius.s),
                ),
                child: Icon(
                  Icons.chevron_right, size: 14,color: string2Color('#FCC53A'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // 学习记录
  renderLearnRecord() =>
  Container(
    margin: EdgeInsets.fromLTRB(Gpadding.m, 165, Gpadding.m, 0),
    height: 110,
    padding: EdgeInsets.fromLTRB(Gpadding.m, Gpadding.s, Gpadding.m, Gpadding.s),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Gradius.s),
      boxShadow: [
        Gshadow.black(0, 3, .16, 6, 0),
      ]
    ),
    child: Column(
      children: <Widget>[
        Text(
          '我的学习记录',
          style: TextStyle(fontSize: FontSize.l, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.only(top: Gpadding.m)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: renderColumn('学习时长(分钟)', '100'),
            ),
            renderVerticalDivider(),
            Expanded(
              child: renderColumn('课程数量', '5'),
            ),
            renderVerticalDivider(),
            Expanded(
              child: renderColumn('个人成绩', 'A')
            ),
          ],
        )
      ],
    ),
  );

  // 学习记录item
  Widget renderColumn(String title, String value) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: FontSize.s),
        ),
        Padding(padding: EdgeInsets.only(top: 2)),
        Text(
          value,
          style: TextStyle(fontSize: FontSize.xxl, color: Colors.blue, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  // 垂直分割线
  Widget renderVerticalDivider() => Container(
    width: 1,
    height: 20,
    color: Colors.blue,
  );

  // 菜单项
  List<Widget> renderMenus() {
    return menuData.map((item) => 
      Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: FontColor.wDivider)),
        ),
        child: ListTile(
          onTap: () { onClickMenuItem(item); },
          leading: Image.asset(item["icon"], width: 26, height: 26),
          title: Text(item["title"]),
          trailing: Icon(Icons.chevron_right, color: Colors.black, size: 20),
        ),
      )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(Gpadding.m, Gsize.statusBarHeight, Gpadding.m, 0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromRGBO(45, 118, 202, 0.8), Color.fromRGBO(72, 131, 202, 0.8)],
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white,),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 200,
                  padding: EdgeInsets.only(top: Gpadding.s, left: Gpadding.m, right: Gpadding.m),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromRGBO(45, 118, 202, 0.8), Color.fromRGBO(72, 131, 202, 0.8)],
                    )
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/images/avatar.jpeg'),
                            radius: 32,
                          ),
                          Padding(padding: EdgeInsets.only(right: Gpadding.s)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '唐东东',
                                      style: TextStyle(fontSize: 22, color: FontColor.white, fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () { showProfile(context); },
                                      child: Row(
                                        children: <Widget>[
                                          Text('我的资料卡', style: TextStyle(color: FontColor.white)),
                                          Icon(Icons.chevron_right, color: Colors.white, size: 18),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 2)),
                                Container(
                                  padding: EdgeInsets.only(left: 2),
                                  width: 64,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: string2Color('#FF9F22'),
                                    borderRadius: BorderRadius.all(Radius.circular(3)),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset('assets/icons/me/medal.png', width: 20, height: 20),
                                      Text(
                                        '0勋章',
                                        style: TextStyle(fontSize: FontSize.s, color: FontColor.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 40,
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(55)),
                      border: Border.all(width: 20, color: Color.fromRGBO(246, 246, 246, .17)),
                    ),
                  ),
                ),
                renderLevel(),
                renderLearnRecord(),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(Gpadding.m, Gpadding.m, Gpadding.m, Gpadding.l),
              padding: EdgeInsets.all(Gpadding.m),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Gradius.s),
                boxShadow: [Gshadow.black(0, 1, .05, 1, 0)]
              ),
              child: Column(
                children: renderMenus(),
              ),
            ),
          ],
        ),
      ) 
    );
  }
}
