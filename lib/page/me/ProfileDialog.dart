import 'package:flutter/material.dart';
import '../../style/index.dart';
import '../../utils/utils.dart';

class ProfileDialog extends StatelessWidget {
  
  Widget renderModelColumn(String title, String value) {
      return Expanded(
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: FontSize.s, color: FontColor.grey),
            ),
            Padding(padding: EdgeInsets.only(top: 2)),
            Text(
              value,
              style: TextStyle(color: string2Color('#44444F'), fontWeight: FontWeight.bold),
            )
          ],
        ),
      ); 
    }

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      contentPadding: EdgeInsets.all(0),
      // 让弹层背景透明
      backgroundColor: Color.fromRGBO(0, 0, 0, 0), 
      content: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 60),
            padding: EdgeInsets.only(top: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Gradius.l, topRight: Gradius.l),
              gradient: LinearGradient(
                colors: [string2Color('#5C9BE4'), string2Color('#3681D7')],
              )
            ),
            height: 100,
            width: 330,
            child: Column(
              children: [
                Text(
                  '唐东东',
                  style: TextStyle(fontSize: FontSize.xl, color: FontColor.white, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.only(top: Gpadding.xs)),
                Text(
                  '202002044590',
                  style: TextStyle(color: FontColor.white),
                )
              ]
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpeg'),
                radius: 40,
              ),
            ], 
          ),
          Container(
            width: 330,
            margin: EdgeInsets.only(top: 160),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(width: 1, color: FontColor.divider)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/icons/me/man.png', width: 16, height: 16),
                Padding(padding: EdgeInsets.only(right: Gpadding.xs)),
                Text(
                  '26岁 广东省·广州市',
                  style: TextStyle(fontSize: FontSize.s, color: FontColor.black),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Gradius.l, bottomRight: Gradius.l),
            ),
            padding: EdgeInsets.fromLTRB(Gpadding.m, Gpadding.s, Gpadding.m, 0),
            height: 120,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    renderModelColumn('学习时长(分钟)', '100'),
                    renderModelColumn('课程数', '5'),
                    renderModelColumn('综合评价', 'A'),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: Gpadding.s)),
                Row(
                  children: [
                    renderModelColumn('出勤率', '90%'),
                    renderModelColumn('收藏课程', '10'),
                  ]
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}