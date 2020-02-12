import 'package:flutter/material.dart';

class CurrentIndexProvider with ChangeNotifier {
  int curIndex = 0;
  void changeIndex(int index) {
    curIndex = index;
    notifyListeners();
  }
}