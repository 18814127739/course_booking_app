import 'package:flutter/material.dart';
import 'package:course_booking_app/page/common_widget/bottom_bar.dart';
import 'package:course_booking_app/style/index.dart';

class BaseLayout extends StatelessWidget {
  String title;
  List<Widget> actions;
  BottomBar bottomBar;
  Widget child;
  
  BaseLayout({this.title, this.actions, this.bottomBar, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          title, 
          style: TextStyle(fontSize: FontSize.xxl, color: FontColor.appBar, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.chevron_left, size: 32),
          color: FontColor.appBar,
        ),
        actions: actions ?? null,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            if(child != null) child,
            if(bottomBar != null) bottomBar,
          ],
        ),
      ),
    );
  }
}