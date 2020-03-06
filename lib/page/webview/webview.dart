import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:course_booking_app/page/common_widget/base_layout.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:image/image.dart';

class WebViewPage extends StatefulWidget {

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebViewPage> {
  WebViewController controller;
  bool loading = false;

  JavascriptChannel savePhotos(BuildContext context) => JavascriptChannel(
    name: 'savePhotos', // 与h5 端的一致 不然收不到消息
    onMessageReceived: (JavascriptMessage msg) async {
      String base64Str = msg.message.split(',')[1];
      Uint8List imageBytes = Base64Decoder().convert(base64Str);
      print(imageBytes);
      final result = await ImageGallerySaver.saveImage(imageBytes);
      // 保存网络图片到本地
      // String url = 'https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg';
      // var response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
      // final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      if(result) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('已保存到相册'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  );

  JavascriptChannel takePhotos(BuildContext context) => JavascriptChannel(
    name: 'takePhotos',
    onMessageReceived: (JavascriptMessage msg) async {
      print(msg);
    }
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: '收钱哆',
      child: Stack(
        children: <Widget>[
          WebView(
            // initialUrl: 'http://175.6.136.234:9000/#/',
            // initialUrl: 'http://192.168.0.100:3000/#/',
            initialUrl: 'http://10.45.102.152:3000/#/',
            userAgent: 'flutter_app', // h5 可以通过navigator.userAgent判断当前环境
            javascriptMode: JavascriptMode.unrestricted, // 启用 js交互，默认不启用JavascriptMode.disabled
            javascriptChannels: <JavascriptChannel>[
              savePhotos(context),
            ].toSet(),
            onWebViewCreated: (WebViewController webViewController) {
              controller = webViewController;
            },
            // navigationDelegate: (NavigationRequest request) {
            //   // 在页面跳转之前调用，TODO isForMainFrame为false,页面不跳转.导致网页内很多链接点击没效果
            //   if(false) {
            //     return NavigationDecision.prevent; // 禁止跳转;
            //   }
            //   return NavigationDecision.navigate; // 跳转;
            // },
            onPageFinished: (String value) {
              setState(() {
                loading = false;
              });
              // webview 页面加载完成调用
              // flutter 调用h5 端方法
              controller.evaluateJavascript('document.title').then((title) {
                print(title);
              });
            },
          ),
        ],
      ),
    );
  }
}