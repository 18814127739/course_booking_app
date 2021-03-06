import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:course_booking_app/router/application.dart';
import 'package:course_booking_app/model/comment_model.dart';
import 'package:course_booking_app/model/course_detail_model.dart';
import 'package:course_booking_app/style/index.dart';
import '../common_widget/banner.dart';
import '../common_widget/bottom_bar.dart';
import '../common_widget/comment_item.dart';

class CourseDetail extends StatefulWidget {
  String id;

  CourseDetail(this.id);

  @override
  CourseDetailState createState() => CourseDetailState();
}

class CourseDetailState extends State<CourseDetail> {
  double whiteBarOpacity = 0; // 白色顶部透明度
  ScrollController scrollController = ScrollController();
  CourseDetailModel detail;
  List<CommentModel> comments;
  final double TOPBAR_HEIGHT = Gsize.statusBarHeight + Gpadding.xs + 30;

  @override
  void initState() {
    super.initState();
    double opacity;
    scrollController.addListener(() {
      opacity = scrollController.offset / TOPBAR_HEIGHT / 1.5;
      setState(() {
        if(opacity > 1) {
          whiteBarOpacity = 1;
        } else if(opacity < 0) {
          whiteBarOpacity = 0;
        } else {
          whiteBarOpacity = opacity;
        }
      });
    });
    // 初始化课程详情数据
    detail = CourseDetailModel.fromJson({
      "id": widget.id,
      "name": "寒假全期小/初/高数学辅导班",
      "like": false,
      "orgName": "悦学悦知辅导机构",
      "orgAddr": "东风路东风街道102号",
      "orgPhone": "18814127777",
      "orgFoundedTime": "1997年10月",
      "orgConcept": "愉快教育成功教育",
      "price": 59.00,
      "dailyPrice": 165.0,
      "images": 'assets/images/courses/6.png,assets/images/courses/4.png,assets/images/courses/3.png',
      "orgInfo": """
      卓越教育目前每年就读学生超过30万人次，拥有一支逾3000名优秀教师的师资队伍，开设了包括辅导班、一对一个性辅导、全日制高四(高考复读)、全日制初四(中考复读)在内100多个校区，遍布广州、上海、深圳、成都、佛山、珠海、东莞、中山、揭阳等城市，2010年、2011年连续两年入围“德勤高科技、高成长中国50强”，多年来获得多项来自政府、社会、媒体授予的奖项和荣誉。
      """
    });
    comments = List.generate(5, (index) => CommentModel.fromJson({
      "id": "$index",
      "userName": "丽丽妈妈",
      "score": 4,
      "avatar": "assets/images/dog.jpeg",
      "date": "2018-10-10 10:00:00",
      "content": "老师认真负责，孩子说课堂十分有趣，自己收获颇多，希望能有效提高孩子成绩。",
    })).toList();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void goBack() {
    Navigator.pop(context);
  }

  // 回到顶部
  void scrollTop(BuildContext context) {
    scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  // 切换收藏
  void toggleLike() {
    setState(() {
      detail.like = !detail.like;
    });
  }

  void checkComments() {
    Application.router.navigateTo(
      context,
      '/commentList?id=${detail.id}&price=${detail.price}&dailyPrice=${detail.dailyPrice}',
      transition: TransitionType.fadeIn,
    );
  }

  // 显示学校简介
  void showOrgInfo() async {
    Widget rowItem(String label, String value) => Container(
      padding: EdgeInsets.symmetric(vertical: Gpadding.s),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: FontColor.wDivider)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(label, style: TextStyle(color: FontColor.grey, fontSize: FontSize.l)),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.black87, fontSize: FontSize.l),
            ),
          ),
        ],
      ),
    );

    final res = await showModalBottomSheet(
      context: context,
      // 设置透明背景
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(Gpadding.m),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Gradius.l, topRight: Gradius.l),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Container()),
                  Expanded(
                    child: Center(
                      child: Text(
                        '学校简介', 
                        style: TextStyle(color: Colors.black87, fontSize: FontSize.xl, fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () { Navigator.pop(context, 'close'); },
                          child: Icon(Icons.close),
                        ),
                      ],
                    ) ,
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: Gpadding.m)),
                    rowItem('名称', detail.orgName),
                    rowItem('创办时间', detail.orgFoundedTime),
                    rowItem('办学理念', detail.orgConcept),
                    Padding(padding: EdgeInsets.only(top: Gpadding.s)),
                    Text('学校介绍', style: TextStyle(color: FontColor.grey, fontSize: FontSize.l)),
                    Padding(padding: EdgeInsets.only(top: Gpadding.s)),
                    Text(
                      detail.orgInfo, 
                      style: TextStyle(color: Colors.black87),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: Gpadding.m)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    print(res);
  }

  // 透明背景顶部栏
  Widget transparentBar(BuildContext context) => 
    Container(
      padding: EdgeInsets.fromLTRB(Gpadding.s, Gsize.statusBarHeight + Gpadding.xs, Gpadding.s, Gpadding.s),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, .4),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Icon(Icons.chevron_left, color: Colors.white, size: 30),
              ),
            ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .4),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
              child: Icon(Icons.vertical_align_top, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );

  // 白色背景顶部栏
  Widget whiteBar(BuildContext context) => 
  Opacity(
    opacity: whiteBarOpacity,
    child: Container(
      padding: EdgeInsets.fromLTRB(Gpadding.s, Gsize.statusBarHeight + Gpadding.xs, Gpadding.s, Gpadding.s),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: goBack,
            child: 
            SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: Icon(Icons.chevron_left, color: Colors.black, size: 30),
              ),
            ),
          ),
          GestureDetector(
            onTap: () { scrollTop(context); },
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
              onTap: showOrgInfo,
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
              onTap: checkComments,
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
        ...comments.map((item) => 
          Container(
            key: UniqueKey(),
            margin: EdgeInsets.only(top: Gpadding.s),
            padding: EdgeInsets.all(Gpadding.s),
            decoration: BoxDecoration(
              color: BgColor.grey,
              borderRadius: BorderRadius.all(Gradius.xs),
            ),
            child:CommentItem(
              key: UniqueKey(),
              comment: item, 
              isShowImgs: false
            ),
          ),
        ).toList(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    List<String> bannerData = detail.images.split(',');

    return Scaffold(
      // safeArea包裹使界面在iphoneX的刘海屏幕中正常显示
      body: Container(
        width: Gsize.deviceWidth,
        height: Gsize.deviceHeight,
        padding: EdgeInsets.only(bottom: Gsize.bottomHeight),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              // 设置controller后, 当屏幕宽度不足一屏时, 默认不会滚动, 可通过设置physics使list可以滑动
              // physics: AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              child: Column(
                children: <Widget>[
                  MyBanner(bannerData),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(Gpadding.m, Gpadding.s, Gpadding.m, Gpadding.s),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          detail.name, 
                          style: TextStyle(color: Colors.black87, fontSize: FontSize.l, fontWeight: FontWeight.bold)
                        ),
                        GestureDetector(
                          onTap: toggleLike,
                          child: detail.like ? Icon(Icons.favorite, color: FontColor.red) : 
                            Icon(Icons.favorite_border, color: FontColor.grey),
                        ),
                      ],
                    ),
                  ),
                  renderOrgInfo(),
                  renderComment(),
                ],
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                return transparentBar(context);
              },
            ),
            Builder(
              builder: (BuildContext context) {
                return whiteBar(context);
              },
            ),
            BottomBar(
              courseId: detail.id, 
              coursePrice: detail.price, 
              courseDailyPrice: detail.dailyPrice,
            ),
          ],
        ),
      ),
    );
  }
}