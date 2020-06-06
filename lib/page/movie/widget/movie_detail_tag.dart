import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/util/toast.dart';
import 'package:imorec/util/utility.dart';

class MovieDetailTag extends StatelessWidget {
  final List tags;

  MovieDetailTag(this.tags);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '所属频道',
              style: TextStyle(
                fontSize: fixedFontSize(16),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox.fromSize(
            size: Size.fromHeight(30.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (BuildContext context, int index) => buildTag(context, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTag(BuildContext context, int index) {
    String tag = tags[index];
    double paddingRight = 0;
    if (index == tags.length - 1) {
      paddingRight = 15;
    }
    return GestureDetector(
      onTap: () {
        Toast.show('开发中...');
      },
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 5),
        margin: EdgeInsets.only(left: 15, right: paddingRight),
        decoration: BoxDecoration(
          color: Color(0x66000000),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              tag,
              style: TextStyle(
                fontSize: fixedFontSize(12),
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}