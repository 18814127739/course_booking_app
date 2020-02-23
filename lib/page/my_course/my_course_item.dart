import 'package:flutter/material.dart';
import 'package:course_booking_app/style/index.dart';
import 'package:course_booking_app/model/my_course_model.dart';

class MyCourseItem extends StatelessWidget {
  MyCourseModel data;

  MyCourseItem({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Gpadding.s),
      margin: EdgeInsets.only(bottom: Gpadding.l, left: Gpadding.m, right: Gpadding.m),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Gradius.s),
        color: Colors.white,
        boxShadow: [Gshadow.black(0, 2, .16, 4, 0)],
      ),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Image.asset(data.image, width: 82, height: 82, fit: BoxFit.cover),
              Padding(padding: EdgeInsets.only(right: Gpadding.m)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.name, style: TextStyle(fontSize: FontSize.xl, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: Gpadding.xs)),
                    Text(
                      data.teacher, style: TextStyle(fontSize: FontSize.l, color: Colors.black87),
                    ),
                    Padding(padding: EdgeInsets.only(top: Gpadding.xs)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '共${data.total}学时', style: TextStyle(fontSize: FontSize.l, color: FontColor.grey),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '${data.finish}', style: TextStyle(fontSize: FontSize.l, color: Colors.blue),
                            ),
                            Text(
                              '/${data.total}', style: TextStyle(fontSize: FontSize.l, color: FontColor.grey),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: Gpadding.m)),
          Row(
            children: <Widget>[
              Expanded(
                // 通过SizeBox包裹进度条设置进度条高度
                child: SizedBox(
                  height: 4,
                  child: LinearProgressIndicator(
                    backgroundColor: FontColor.divider,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: data.finish / data.total,
                  ),
                ), 
              ),
              Padding(padding: EdgeInsets.only(right: Gpadding.s)),
              Text(
                '${(data.finish / data.total) * 100}%', style: TextStyle(fontSize: FontSize.s, color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ]
      ),
    );
  }
}