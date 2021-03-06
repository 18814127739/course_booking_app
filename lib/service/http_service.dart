import 'package:dio/dio.dart';
import 'dart:async';
import '../constant/index.dart';

Future request(url, {formData}) async {
  String newUrl = 'http://${Config.IP}:${Config.PORT}${url}';

  try {
    Response res;
    Dio dio = Dio();
    dio.options.contentType = 'application/x-www-form-urlencoded';
    res = await dio.post(newUrl, data: formData);
    if (res.statusCode == 200) {
      // 成功返回
      return res;
    } else {
      throw Exception('接口返回异常');
    }
  } catch (e) {
    return print('error:::$e');
  }
}
