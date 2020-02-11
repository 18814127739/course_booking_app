import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../page/index_page.dart';

Handler rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return IndexPage();
  }
);
