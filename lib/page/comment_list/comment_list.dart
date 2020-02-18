import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../../model/comment_model.dart';
import '../../router/application.dart';
import '../../style/index.dart';
import '../common_widget/bottom_bar.dart';
import '../common_widget/comment_item.dart';

class CommentList extends StatefulWidget {
  String courseId;
  double coursePrice;
  double courseDailyPrice;

  CommentList(this.courseId, this.coursePrice, this.courseDailyPrice);

  @override
  CommentListState createState() => CommentListState();
}

class CommentListState extends State<CommentList> {
  List<CommentModel> commentList;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    commentList = List.generate(10, (index) => CommentModel.fromJson({
      "id": "$index",
      "userName": "丽丽妈妈",
      "score": 4,
      "avatar": "assets/images/dog.jpeg",
      "date": "2018-10-10 10:00:00",
      "content": "老师认真负责，孩子说课堂十分有趣，自己收获颇多，希望能有效提高孩子成绩。",
      "images": "assets/images/comment.png,assets/images/comment.png,assets/images/comment.png,assets/images/comment.png",
    })).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          '课程评价', 
          style: TextStyle(fontSize: FontSize.xxl, color: FontColor.appBar, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.chevron_left, size: 32),
          color: FontColor.appBar,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(Gpadding.m, 0, Gpadding.m, Gpadding.xxl * 2),
              color: Colors.white,
              child: ListView.builder(
                controller: controller,
                itemCount: commentList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: Gpadding.m),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(width: 1, color: FontColor.wDivider)),
                    ),
                    child: CommentItem(commentList[index], true),
                  );
                }
              ),
            ),
            BottomBar(widget.courseId, widget.coursePrice, widget.courseDailyPrice),
          ],
        ),
      ),
    );
  }
}