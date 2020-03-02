import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebViewPage> {
  WebViewController controller;

  JavascriptChannel jsBridge(BuildContext context) => JavascriptChannel(
    name: 'flutter_app',
    onMessageReceived: (JavascriptMessage msg) async {
      print(msg.message);
    } 
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WebView(
          initialUrl: 'http://175.6.136.234:9000/#/',
          userAgent: 'flutter_app', // h5 可以通过navigator.userAgent判断当前环境
          javascriptMode: JavascriptMode.unrestricted, // 启用 js交互，默认不启用JavascriptMode.disabled
          javascriptChannels: <JavascriptChannel>[
            jsBridge(context) // 与h5 通信
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
            // webview 页面加载调用
            // flutter 调用h5 端方法
            controller.evaluateJavascript('document.title').then((title) {
              print(title);
            });
          },
        ),
      ],
    );
  }
}