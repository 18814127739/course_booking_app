import 'package:course_booking_app/model/comment_model.dart';
import 'package:flutter/material.dart';
import '../../style/index.dart';

class CommentItem extends StatelessWidget {
  CommentModel comment;

  CommentItem(@required this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Gpadding.s),
      padding: EdgeInsets.all(Gpadding.s),
      decoration: BoxDecoration(
        color: BgColor.grey,
        borderRadius: BorderRadius.all(Gradius.xs),
      ),
      child: Column(
        children: <Widget>[
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }
}