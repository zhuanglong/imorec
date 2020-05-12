import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/app/app_color.dart';
import 'package:imorec/modal/movie_detail_modal.dart';
import 'package:imorec/util/screen.dart';
import 'package:imorec/util/utility.dart';
import 'package:imorec/widget/movie_cover_image_widget.dart';
import 'package:imorec/widget/rating_widget.dart';
import 'package:imorec/page/movie/widget/join_string.dart';

class MovieDetialTag extends StatelessWidget {
  final List tags;

  MovieDetialTag(this.tags);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '所属频道',
              style: TextStyle(
                fontSize: fixedFontSize(16),
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox.fromSize(
            size: Size.fromHeight(30.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (BuildContext context, int index) => _buildTag(context, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag() {
    return Container();
  }
}