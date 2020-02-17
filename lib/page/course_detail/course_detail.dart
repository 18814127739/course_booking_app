import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../../router/application.dart';
import '../../model/comment_model.dart';
import '../../model/course_detail_model.dart';
import '../../style/index.dart';
import '../../utils/utils.dart';
import '../common_widget/banner.dart';
import 'comment_item.dart';

class CourseDetail extends StatefulWidget {
  String id;

  CourseDetail(this.id);

  @override
  CourseDetailState createState() => CourseDetailState();
}

class CourseDetailState extends State<CourseDetail> {
  double transparentBarOpacity = 1; // 透明顶部透明度
  double whiteBarOpacity = 0; // 白色顶部透明度
  ScrollController scrollController = ScrollController();
  CourseDetailModel detail;
  List<CommentModel> comments;

  @override
  void initState() {
    scrollController.addListener(() {
      print(scrollController.offset);
      // 根据滑动距离切换导航栏
      if(scrollController.offset > 40) {
        setState(() {
          whiteBarOpacity = 1;
          transparentBarOpacity = 0;
        });
      } else {
        setState(() {
          whiteBarOpacity = 0;
          transparentBarOpacity = 1;
        });
      }
    });
    detail = CourseDetailModel.fromJson({
      "id": widget.id,
      "name": "寒假全期小/初/高数学辅导班",
      "like": false,
      "orgName": "悦学悦知辅导机构",
      "orgAddr": "东风路东风街道102号",
      "orgPhone": "18814127777",
      "price": 59.00,
      "dailyPrice": 165.0,
      "images": 'assets/images/courses/6.png,assets/images/courses/4.png,assets/images/courses/3.png'
    });
    comments = List.generate(5, (index) {
      return CommentModel.fromJson({
        "id": "$index",
        "userName": "丽丽妈妈",
        "score": 4,
        "avatar": "assets/images/dog.jpeg",
        "date": "2018-10-10 10:00:00",
        "content": "老师认真负责，孩子说课堂十分有趣，自己收货颇多，希望能有效提高孩子成绩。",
      });
    }).toList();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void goBack() {
    print(123);
    Navigator.pop(context);
  }

  void share(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text('功能尚未开发'), duration: Duration(seconds: 2))
    );
  }

  // 切换收藏
  void toggleLike() {
    setState(() {
      detail.like = !detail.like;
    });
  }

  // 预约
  void bookCourse() {
    print('book');
  }

  // 透明背景顶部栏
  Widget transparentBar(double statusBarHeight, BuildContext context) => 
  Opacity(
    opacity: transparentBarOpacity,
    child: Container(
      margin: EdgeInsets.only(top: statusBarHeight),
      padding: EdgeInsets.symmetric(horizontal: Gpadding.s),
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: goBack,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: string2Color('#BFBFBF'),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Icon(Icons.chevron_left, color: Colors.white, size: 30),
              ),
            ),
          ),
          GestureDetector(
            onTap: () { share(context); },
            child:Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: string2Color('#BFBFBF'),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Icon(Icons.vertical_align_top, color: Colors.white, size: 20),
              ),
            ),
          )
        ],
      ),
    ),
  );

  // 白色背景顶部栏
  Widget whiteBar(double statusBarHeight, BuildContext context) => 
  Opacity(
    opacity: whiteBarOpacity,
    child: Container(
      margin: EdgeInsets.only(top: statusBarHeight),
      padding: EdgeInsets.symmetric(horizontal: Gpadding.s),
      height: 42,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: goBack,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: Icon(Icons.chevron_left, color: Colors.black, size: 30),
              ),
            ),
          ),
          GestureDetector(
            onTap: () { share(context); },
            child: SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: Icon(Icons.vertical_align_top, color: Colors.black, size: 20),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // 学校信息
  Widget renderOrgInfo() => 
  Container(
    margin: EdgeInsets.only(top: Gpadding.s),
    padding: EdgeInsets.all(Gpadding.m),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('学校信息', style: TextStyle(color: Colors.black87)),
        Padding(padding: EdgeInsets.only(top: Gpadding.xs)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              detail.orgName,
              style: TextStyle(color: Colors.black87, fontSize: FontSize.l, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () { print('学校简介'); },
              child: Row(
                children: <Widget>[
                  Text(
                    '简介',
                    style: TextStyle(color: Colors.blue),
                  ),
                  Icon(Icons.chevron_right, color: Colors.blue, size: 18),
                ],
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: Gpadding.xs)),
        Text(
          '电话: ${detail.orgPhone}', 
          style: TextStyle(color: Colors.black87, fontSize: FontSize.s),
        ),
        Padding(padding: EdgeInsets.only(top: Gpadding.s)),
        Divider(color: FontColor.divider, height: 2),
        Padding(padding: EdgeInsets.only(top: Gpadding.s)),
        Row(
          children: <Widget>[
            Image.asset('assets/icons/location.png'),
            Padding(padding: EdgeInsets.only(right: Gpadding.s)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  detail.orgAddr,
                  style: TextStyle(color: Colors.black87, fontSize: FontSize.l),
                ),
                Padding(padding: EdgeInsets.only(top: Gpadding.xs)),
                Text(
                  '距您1.1千米',
                  style: TextStyle(color: FontColor.grey, fontSize: FontSize.s),
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );

  // 评论
  Widget renderComment() =>
  Container(
    margin: EdgeInsets.only(top: Gpadding.s, bottom: Gpadding.xxl * 2),
    padding: EdgeInsets.all(Gpadding.m),
    color: Colors.white,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('全网评价', style: TextStyle(color: Colors.black87)),
            GestureDetector(
              onTap: () { print('评价'); },
              child: Row(
                children: <Widget>[
                  Text(
                    '更多',
                    style: TextStyle(color: Colors.blue),
                  ),
                  Icon(Icons.chevron_right, color: Colors.blue, size: 18),
                ],
              ),
            ),
          ],
        ),
        ...comments.map((item) => CommentItem(item)).toList(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double deviceWidth = MediaQuery.of(context).size.width;
    List<String> bannerData = detail.images.split(',');

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            // 设置controller后, 当屏幕宽度不足一屏时, 默认不会滚动, 可通过设置physics使list可以滑动
            physics: AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            children: <Widget>[
              MyBanner(bannerData),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: Gpadding.m),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      detail.name, 
                      style: TextStyle(color: Colors.black87, fontSize: FontSize.l, fontWeight: FontWeight.bold)
                    ),
                    IconButton(
                      onPressed: toggleLike,
                      icon: detail.like ? Icon(Icons.favorite, color: FontColor.red) : Icon(Icons.favorite_border, color: FontColor.grey),
                    )
                  ],
                ),
              ),
              renderOrgInfo(),
              renderComment(),
            ],
          ),
          Builder(
            builder: (BuildContext context) {
              return transparentBar(statusBarHeight, context);
            },
          ),
          Builder(
            builder: (BuildContext context) {
              return whiteBar(statusBarHeight, context);
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: deviceWidth,
              padding: EdgeInsets.fromLTRB(Gpadding.m, Gpadding.m, Gpadding.m, Gpadding.xxl),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '¥${detail.price}',
                        style: TextStyle(color: FontColor.red, fontSize: FontSize.xxl, fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.only(right: Gpadding.xs)),
                      Text(
                        '日常价: ¥${detail.dailyPrice}',
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.s),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: bookCourse,
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
          )
        ],
      ),
    );
  }
}