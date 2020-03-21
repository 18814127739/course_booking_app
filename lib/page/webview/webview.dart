import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;
import 'dart:typed_data';
import 'dart:convert';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:course_booking_app/page/common_widget/base_layout.dart';
import './action_item.dart';
import 'package:course_booking_app/style/index.dart';

class WebViewPage extends StatefulWidget {
  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebViewPage> {
  WebViewController controller;
  bool loading = false;

  // 保存base64图片到本地
  JavascriptChannel savePhotos(BuildContext context) => JavascriptChannel(
    name: 'savePhotos', // 与h5 端的一致 不然收不到消息
    onMessageReceived: (JavascriptMessage msg) async {
      // 解析json字符串
      String str =  json.decode(msg.message);
      // 取出base64的值
      String base64Str = str.split(',')[1];
      Uint8List imageBytes = Base64Decoder().convert(base64Str);
      final result = await ImageGallerySaver.saveImage(imageBytes);
      if(result.isNotEmpty) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('已保存到相册'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  );

  // 拍照/选择相册
  JavascriptChannel takePhotos(BuildContext context) => JavascriptChannel(
    name: 'nativeSelectFile',
    onMessageReceived: (JavascriptMessage msg) async {
      final res = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: 170 + Gsize.bottomHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Gradius.base, topRight: Gradius.s),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                ActionItem(
                  title: '拍摄', 
                  onTap: () async {
                    var image = await ImagePicker.pickImage(source: ImageSource.camera);
                    List<int> imageBytes = await image.readAsBytes();
                    String imageBase64 = convert.base64Encode(imageBytes);
                    Navigator.pop(context, imageBase64);
                  }
                ),
                Divider(color: FontColor.divider, height: 1),
                ActionItem(
                  title: '从手机相册选择', 
                  onTap: () async {
                    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                    List<int> imageBytes = await image.readAsBytes();
                    String imageBase64 = convert.base64Encode(imageBytes);
                    Navigator.pop(context, imageBase64);
                  }),
                Container(
                  height: Gpadding.s,
                  color: BgColor.grey,
                ),
                ActionItem(
                  title: '取消', 
                  onTap: () { 
                    Navigator.pop(context); 
                  }
                ),
              ],
            ),
          );
        }
      );
      if(res != null) {
        Map<String, dynamic> data = json.decode(msg.message);
        String callBack = data['methodName'];
        Map<String, dynamic> returnData = {
          'data': res, // base64图片
          'args': data['args'],
        };
        String params = convert.jsonEncode(returnData);
        controller.evaluateJavascript('$callBack($params)');
      }
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
            initialUrl: 'http://192.168.0.100:3000/#/',
            // initialUrl: 'http://10.45.103.63:3000/#/',
            userAgent: 'flutter_app', // h5 可以通过navigator.userAgent判断当前环境
            javascriptMode: JavascriptMode.unrestricted, // 启用 js交互，默认不启用JavascriptMode.disabled
            javascriptChannels: <JavascriptChannel>[
              savePhotos(context),
              takePhotos(context),
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
              // controller.evaluateJavascript('document.title').then((title) {
              //   print(title);
              // });
            },
          ),
        ],
      ),
    );
  }
}