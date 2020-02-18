import 'package:course_booking_app/model/comment_model.dart';
import 'package:flutter/material.dart';
import '../../style/index.dart';

class CommentItem extends StatelessWidget {
  CommentModel comment;
  bool isShowImgs;

  CommentItem(@required this.comment, this.isShowImgs);

  @override
  Widget build(BuildContext context) {
    List<String> imgs = [];
    if(comment.images != null) {
      imgs = comment.images.split(",");
    }
    bool isShow = this.isShowImgs && imgs.length > 0;

    Widget renderImgs() {
      if(isShow) {
        return SizedBox(
          height: 100,
          child: ListView(
            // 横向滚动, 外层元素必须设置高度
            scrollDirection: Axis.horizontal,
            children: imgs.map((item) => 
              Container(
                margin: EdgeInsets.only(right: Gpadding.s),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Gradius.xs),
                ),
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(item, fit: BoxFit.cover),
                ),
              )
            ).toList(),
          ),
        ); 
      }
      return Container();
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(comment.avatar),
              radius: 20,
            ),
            Padding(padding: EdgeInsets.only(right: Gpadding.m)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        comment.userName,
                        style: TextStyle(color: FontColor.black, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          ...List.generate(
                            comment.score, 
                            (index) => Icon(Icons.star, size: 16, color: FontColor.yellow)
                          ).toList(),
                          ...List.generate(
                            5 - comment.score, 
                            (index) => Icon(Icons.star_border, size: 16, color: FontColor.grey)
                          ).toList(),
                        ],
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 3)),
                  Text(
                    comment.date,
                    style: TextStyle(color: FontColor.grey, fontSize: FontSize.s),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: Gpadding.m)),
        Text(
          comment.content,
          maxLines: 2,
          style: TextStyle(fontSize: FontSize.s, color: FontColor.black),
        ),
        Padding(padding: EdgeInsets.only(top: isShow ? Gpadding.m : 0)),
        renderImgs(),
      ],
    );
  }
}