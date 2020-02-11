import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        leading: Container(),
      ),
      body: Center(
        child: Text('首页'),
      ),
    );
  }
}