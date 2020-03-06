import 'package:flutter/foundation.dart';

class LargeImageProvider extends ChangeNotifier {
  List<String> _images = [];

  List<String> get images => _images;

  void changeImages(List<String> imgs) {
    _images = imgs;
    notifyListeners(); // 通知界面刷新
  }
}