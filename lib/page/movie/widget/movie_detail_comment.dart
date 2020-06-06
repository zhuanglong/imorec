import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/modal/movie_comment_modal.dart';
import 'package:imorec/util/movie_data_util.dart';
import 'package:imorec/widget/rating_widget.dart';

const double boxWidth = 160;
const double boxHeight = 120;
const EdgeInsets boxInterval = EdgeInsets.only(left: 15, bottom: 15);

class MovieDetailComment extends StatelessWidget {
  final List<MovieCommentModal> comments;

  MovieDetailComment(this.comments);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    Widget noComment = Text('暂无短评', style: TextStyle(color: Colors.white, fontSize: 14));
    for (var i = 0; i < comments.length; i++) {
      children.add(CommentItem(comments[i]));
    }
    if (comments.length == 0) {
      children.add(noComment);
    }

    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0x66000000),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('短评', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Column(
            children: children,
          ),
        ],
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final MovieCommentModal comment;

  CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF888888), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(comment.author.avatar),
                radius: 16,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    comment.author.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: <Widget>[
                      StaticRatingBar(size: 12.0,rate: comment.rating.value),
                      SizedBox(width: 10),
                      Text(
                        comment.time.split(' ')[0],
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFDDDDDD)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(comment.content, style: TextStyle(fontSize: 14, color: Colors.white)),
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              Icon(Icons.thumb_up, color: Color(0xFFDDDDDD), size: 12),
              SizedBox(width: 5),
              Text(MovieDataUtil.number2Unit(comment.usefulCount), style: TextStyle(fontSize: 12, color: Color(0xFFDDDDDD))),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}