import 'package:flutter/material.dart';
import 'package:course_booking_app/page/common_widget/base_layout.dart';
import 'package:course_booking_app/style/index.dart';
import 'package:course_booking_app/model/my_course_detail_model.dart';
import 'package:course_booking_app/router/application.dart';

class MyCourseDetail extends StatefulWidget {
  String id;
  MyCourseDetail(this.id);
  @override
  MyCourseDetailState createState() => MyCourseDetailState();
}

class MyCourseDetailState extends State<MyCourseDetail> {
  MyCourseDetailModel detail;

  @override
  void initState() {
    super.initState();
    setState(() {
      detail = MyCourseDetailModel.fromJson({
        'id': widget.id,
        'name': '美术趣味课堂_${widget.id}',
        'image': 'assets/images/courses/1.png',
        'teacher': '李老师',
        'total': 48,
        'finish': 42,
        'rest': 6,
        'beginDate': '2020-02-16',
        'endDate': '2020-08-16',
        'coursePlan': [
          ['周一', '9:00', '11:00'],
          ['周三', '15:00', '17:00'],
          ['周五', '19:00', '21:00'],
        ]
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: '课程内容',
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: Gpadding.l, left: Gpadding.m, right: Gpadding.m),
        child: Column(
          children: <Widget>[
            renderBaseInfo(),
            renderCourseProgress(),
            renderBtnGroup(),
            renderCoursePlan(),
          ],
        ),
      ),
    );
  }

  // 课程基本信息
  Widget renderBaseInfo() => Row(
    children: <Widget>[
      Hero(
        tag: detail.id,
        child: GestureDetector(
          onTap: () {
            String url = Uri.encodeComponent('assets/video/test.mp4');
            Application.router.navigateTo(context, '/videoPage?url=$url&tag=${detail.id}');
          },
          child: Image.asset(detail.image, width: 96, height: 96, fit: BoxFit.cover),
        ),
      ),
      Padding(padding: EdgeInsets.only(right: Gpadding.m)),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              detail.name, style: TextStyle(fontSize: FontSize.xl, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: Gpadding.xs)),
            Text(
              detail.teacher, style: TextStyle(fontSize: FontSize.l, color: Colors.black87),
            ),
            Padding(padding: EdgeInsets.only(top: Gpadding.xs)),
            Text(
              '开始时间: ${detail.beginDate}', style: TextStyle(color: FontColor.grey),
            ),
            Text(
              '结束时间: ${detail.endDate}', style: TextStyle(color: FontColor.grey),
            ),
          ],
        ),
      ),
    ],
  );

  // 课程进度
  Widget renderCourseProgress() {
    // 垂直分割线
    Widget renderVerticalDivider() => Container(
      width: 1,
      height: 14,
      color: FontColor.divider,
    );

    Widget renderColumn(String title, int value) => Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: FontColor.grey),
        ),
        Padding(padding: EdgeInsets.only(top: 2)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              '$value',
              style: TextStyle(fontSize: FontSize.xl, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            Text(
              '课时',
              style: TextStyle(fontSize: FontSize.s, color: Colors.black87),
            ),
          ],
        )
      ],
    );

    return Container(
      margin: EdgeInsets.only(top: Gpadding.l),
      padding: EdgeInsets.all(Gpadding.m),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Gradius.s),
        color: Colors.white,
        boxShadow: [Gshadow.black(0, 3, .16, 6, 0)]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: renderColumn('完成', detail.finish),
              ),
              renderVerticalDivider(),
              Expanded(
                child: renderColumn('剩余', detail.rest),
              ),
              renderVerticalDivider(),
              Expanded(
                child: renderColumn('总共', detail.total)
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: Gpadding.m)),
          Row(
            children: <Widget>[
              Text(
                '课程进度',
                style: TextStyle(color: Colors.black87),
              ),
              Padding(padding: EdgeInsets.only(right: Gpadding.s)),
              Expanded(
                child: SizedBox(
                  height: 4,
                  child: LinearProgressIndicator(
                    backgroundColor: FontColor.divider,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: detail.finish / detail.total,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(right: Gpadding.s)),
              Text(
                '${(detail.finish / detail.total) * 100}%',
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  } 

  // 点评按钮
  Widget renderBtnGroup() {
    Widget renderButtonItem(String title, Color color) => Container(
      height: 46,
      width: 130,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: color),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: FontSize.xl, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: Gpadding.xxl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print('待开发');
            },
            child: renderButtonItem('点评老师', FontColor.yellow),
          ),
          Padding(padding: EdgeInsets.only(right: Gpadding.xxl)),
          GestureDetector(
            onTap: () {
              print('待开发');
            },
            child: renderButtonItem('点评课程', FontColor.green),
          ),
        ],
      ),
    );
  }

  // 课程安排
  renderCoursePlan() {
    // 屏幕宽度 - 左右边距 / 3,  得到每列宽度
    double columnWidth = (MediaQuery.of(context).size.width - 2 * Gpadding.m) / 3;
    // 绘制单元格
    Widget tableCell(String text, Color textColor, Color bgColor) {
      return Container(
        color: bgColor,
        padding: EdgeInsets.symmetric(vertical: Gpadding.xs),
        child: Center(
          child: Text(text, style: TextStyle(color: textColor)),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: Gpadding.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '课程安排', 
            style: TextStyle(fontSize: FontSize.l, color: Colors.black87, fontWeight: FontWeight.bold)
          ),
          Padding(padding: EdgeInsets.only(top: Gpadding.s)),
          Table(
            columnWidths: {
              0: FixedColumnWidth(columnWidth),
              1: FixedColumnWidth(columnWidth),
              2: FixedColumnWidth(columnWidth),
            },
            border: TableBorder.all(color: FontColor.divider, width: 1, style: BorderStyle.solid),
            children: [
              // 表头
              TableRow(
                children: [
                  tableCell('上课安排', FontColor.grey, BgColor.grey),
                  tableCell('开始时间', FontColor.grey, BgColor.grey),
                  tableCell('结束时间', FontColor.grey, BgColor.grey),
                ]
              ),
              // 表格数据
              ...detail.coursePlan.map((List<String> item) => TableRow(
                children: item.map((c) => tableCell(c, Colors.black87, Colors.white)).toList()
              )).toList(),
            ],
          ),
        ],
      ),
    );
  }
}