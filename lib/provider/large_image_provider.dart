import 'package:flutter/material.dart';

class LargeImageProvider extends ChangeNotifier {
  List<String> images = [];

  void changeImages(List<String> imgs) {
    images = imgs;
    notifyListeners(); // 通知界面刷新
  }
}