import 'package:flutter/foundation.dart';

class CurrentIndexProvider with ChangeNotifier {
  int _curIndex = 0;

  int get curIndex => _curIndex;
  
  void changeIndex(int index) {
    _curIndex = index;
    notifyListeners();
  }
}