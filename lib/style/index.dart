import 'package:flutter/material.dart';
import '../utils/utils.dart';

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
}

class Gradius {
  static const Radius s = Radius.circular(10);
  static const Radius base = Radius.circular(15);
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