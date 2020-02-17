import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../page/index_page.dart';
import '../page/my_course/my_course.dart';
import '../page/my_course_detail/my_course_detail.dart';
import '../page/course_detail/course_detail.dart';

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

Handler myCourseDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MyCourseDetail(params["id"].first);
  }
);

Handler courseDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return CourseDetail(params["id"].first);
  }
);