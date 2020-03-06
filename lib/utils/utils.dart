import 'package:flutter/material.dart';

// 颜色转换工具
Color string2Color(String colorString) {
  int value = 0x00000000;
  if(colorString[0] == '#') {
    colorString = colorString.substring(1);
  }
  value = int.tryParse(colorString, radix: 16);
  if(value != null) {
    if(value < 0xff000000) {
      value += 0xff000000;
    }
  }
  return Color(value);
}

// 秒 ——> 时:分:秒
String getTimeStr(int s){
  if( s > 0) {
    int hs = (s / 3600).floor();
    int ms = ((s - 3600 * hs) / 60).floor();
    int ss = ((s - 3600 * hs - ms * 60) % 60).floor();
    String hStr = hs > 0 ? hs > 9 ? '$hs:' : '0$hs:' : '';
    String mStr = ms > 0 ? ms > 9 ? '$ms:' : '0$ms:' : '00:';
    String sStr = ss > 0 ? ss > 9 ? '$ss' : '0$ss' : '00';
    return '$hStr$mStr$sStr';
  }
  return '00:00';
}