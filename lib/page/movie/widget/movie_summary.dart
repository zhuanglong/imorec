import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/common/style/app_style.dart';
import 'package:imorec/util/utility.dart';

class MovieSummary extends StatefulWidget {
  final String summary;

  MovieSummary(this.summary);

  @override
  _MovieSummaryState createState() => _MovieSummaryState();
}

class _MovieSummaryState extends State<MovieSummary> {
  bool isUnfold = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '简介',
            style: TextStyle(
              fontSize: fixedFontSize(16),
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            this.widget.summary,
            maxLines: isUnfold ? null : 4,
            style: TextStyle(
              fontSize: fixedFontSize(14),
              color: AppColor.white,
            ),
          ),
          SizedBox(height: 5),
          GestureDetector(
            onTap: changeSummaryMaxLines,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  isUnfold ? '收起' : '显示全部',
                  style: TextStyle(
                    fontSize: fixedFontSize(14),
                    color: AppColor.white,
                  ),
                ),
                Icon(
                  isUnfold ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColor.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  changeSummaryMaxLines() {
    setState(() {
      isUnfold = !isUnfold;
    });
  }
}