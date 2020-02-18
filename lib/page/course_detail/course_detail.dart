import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../../router/application.dart';
import '../../model/comment_model.dart';
import '../../model/course_detail_model.dart';
import '../../style/index.dart';
import '../../utils/utils.dart';
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
  double transparentBarOpacity = 1; // 透明顶部透明度
  double whiteBarOpacity = 0; // 白色顶部透明度
  ScrollController scrollController = ScrollController();
  CourseDetailModel detail;
  List<CommentModel> comments;

  @override
  void initState() {
    scrollController.addListener(() {
      // 将滑动距离简化成整数
      int offset = int.parse(scrollController.offset.toStringAsFixed(0));
      // 根据滑动距离切换导航栏透明度
      setState(() {
        if(offset < 100 && offset > 0) {
          whiteBarOpacity = offset * 0.01;
          transparentBarOpacity = 1 - whiteBarOpacity;
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
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: Gpadding.l)),
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
            ],
          ),
        );
      },
    );
    print(res);
  }

  // 透明背景顶部栏
  Widget transparentBar(BuildContext context) => 
  Opacity(
    opacity: transparentBarOpacity,
    child: Container(
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
  Widget whiteBar(BuildContext context) => 
  Opacity(
    opacity: whiteBarOpacity,
    child: Container(
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
            margin: EdgeInsets.only(top: Gpadding.s),
            padding: EdgeInsets.all(Gpadding.s),
            decoration: BoxDecoration(
              color: BgColor.grey,
              borderRadius: BorderRadius.all(Gradius.xs),
            ),
            child:CommentItem(item, false),
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
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              // 设置controller后, 当屏幕宽度不足一屏时, 默认不会滚动, 可通过设置physics使list可以滑动
              // physics: AlwaysScrollableScrollPhysics(),
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
                return transparentBar(context);
              },
            ),
            Builder(
              builder: (BuildContext context) {
                return whiteBar(context);
              },
            ),
            BottomBar(detail.id, detail.price, detail.dailyPrice),
          ],
        ),
      ),
    );
  }
}