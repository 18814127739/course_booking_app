import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../page/index_page.dart';
import '../page/my_course/my_course.dart';

Handler rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return IndexPage();
  }
);

Handler myCourseHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MyCourse();
  }
);