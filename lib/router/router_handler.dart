import 'package:course_booking_app/page/large_image/large_image.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../page/index_page.dart';
import '../page/my_course/my_course.dart';
import '../page/my_course_detail/my_course_detail.dart';
import '../page/course_detail/course_detail.dart';
import '../page/comment_list/comment_list.dart';
import '../page/large_image/large_image.dart';
import '../page/video_page/video_page.dart';

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
    return MyCourseDetail(params["id"]?.first);
  }
);

Handler courseDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return CourseDetail(params["id"]?.first);
  }
);

Handler commentListHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    double price = double.parse(params["price"]?.first);
    double dailyPrice = double.parse(params["dailyPrice"]?.first);
    return CommentList(params["id"].first, price, dailyPrice);
  }
);

Handler bigImageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    int index = int.parse(params["index"]?.first);
    String id = params["id"]?.first;
    return LargeImage(index, id);
  }
);

Handler videoPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String url = params["url"]?.first;
    String tag = params["tag"]?.first;
    return VideoPage(url: url, tag: tag);
  }
);