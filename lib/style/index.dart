import 'package:flutter/material.dart';
import 'dart:ui';
import '../utils/utils.dart';

class Gsize {
  // 状态栏高度
  static double statusBarHeight = MediaQueryData.fromWindow(window).padding.top;
  // 屏幕宽度
  static double deviceWidth = MediaQueryData.fromWindow(window).size.width;
  // 屏幕高度
  static double deviceHeight = MediaQueryData.fromWindow(window).size.height;
  // iphoneX大屏底部高度
  static double bottomHeight = MediaQueryData.fromWindow(window).padding.bottom;
}

class FontSize {
  static const double s = 12;
  static const double m = 14;
  static const double l = 16;
  static const double xl = 18;
  static const double xxl = 20;
}

class Gpadding {
  static const double xs = 5;
  static const double s = 10;
  static const double m = 15;
  static const double l = 20;
  static const double xl = 25;
  static const double xxl = 30;
}

class FontColor {
  static Color grey = string2Color('#9E9EA3');
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color red = string2Color('#FF3E30');
  static Color appBar = Colors.black87;
  static Color yellow = string2Color('#FFA200');
  static Color green = string2Color('#45B615');
  static Color blue = string2Color('#4696ec');
  static Color divider = string2Color('#DCDCDC');
  static Color wDivider = string2Color('#f3f3f3'); // 弱分割线
}

class Gradius {
  static const Radius xs = Radius.circular(5);
  static const Radius s = Radius.circular(10);
  static const Radius base = Radius.circular(15);
  static const Radius l = Radius.circular(20);
}

class BgColor {
  static Color grey = string2Color('#F7F8FF');
}

class Gshadow {
  static BoxShadow black(double offsetX, double offsetY, double opacity, double blurRadius, double spreadRadius) {
    return BoxShadow(
      offset: Offset(offsetX, offsetY), // x/y偏移大小
      color: Color.fromRGBO(0, 0, 0, opacity), // 阴影颜色
      blurRadius: blurRadius, //模糊值
      spreadRadius: spreadRadius //扩展阴影半径
    );
  }
}