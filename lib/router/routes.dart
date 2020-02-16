import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'router_handler.dart';

class Routes {
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('error::: router 没有找到');
      }
    );
    // 主页路由
    router.define('/', handler: rootHandler);
    // 我的课程
    router.define('/myCourse', handler: myCourseHandler);
  }
}