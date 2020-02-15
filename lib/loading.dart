import 'package:flutter/material.dart';
import 'router/application.dart';
import 'package:fluro/fluro.dart';
import 'dart:async';
import 'style/index.dart';

class Loading extends StatefulWidget {
  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  int seconds = 3;
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if(seconds > 0) {
          seconds -= 1;
        } else {
          skip(context);
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(timer != null) {
      // 取消定时器
      timer.cancel();
    }
  }

  // 跳转至首页
  skip(BuildContext context) {
    Application.router.navigateTo(context, '/', transition: TransitionType.fadeIn);
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 限定子元素的最大最小宽高, 让图片占满整个屏幕
        ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Image.asset('assets/images/loading/1.jpeg', fit: BoxFit.cover),
        ),
        Positioned(
          top: 140,
          left: 40,
          child: Text(
            '同\n学', 
            style: TextStyle(fontSize: 50, color: Colors.white, decoration: TextDecoration.none)
          ),
        ),
        Positioned(
          top: 210,
          left: 100,
          child: Text(
            '您\n好', 
            style: TextStyle(fontSize: 50, color: Colors.white, decoration: TextDecoration.none)
          ),
        ),
        Positioned(
          top: 50,
          right: 25,
          child: GestureDetector(
            onTap: () { skip(context); },
            child: Container(
              height: 24,
              width: 75,
              // color: Colors.black54,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius:BorderRadius.all(Radius.circular(15))
              ),
              child: Center(
                child: Text(
                  '${seconds}s 跳过',
                  style: TextStyle(
                    fontSize: FontSize.m,
                    color: Colors.white70,
                    decoration: TextDecoration.none
                  ),
                ),
              ), 
            ),
          ),
        ),
      ],
    );
  }
}
