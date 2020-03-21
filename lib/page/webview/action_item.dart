import 'package:flutter/material.dart';
import 'package:course_booking_app/style/index.dart';

class ActionItem extends StatelessWidget {
  String title;
  GestureTapCallback onTap;

  ActionItem({Key key,  @required this.title, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        child: Center(
          child: Text(title, style: TextStyle(fontSize: FontSize.l, color: FontColor.black)),
        ),
      ),
    );
  }
}