import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/app/app_color.dart';
import 'package:imorec/app/app_navigator.dart';
import 'package:imorec/modal/movie_actor_modal.dart';
import 'package:imorec/util/toast.dart';
import 'package:imorec/util/utility.dart';

class MovieDetailCast extends StatefulWidget {
  final List<MovieActorModal> directors;
  final List<MovieActorModal> actors;

  MovieDetailCast(this.directors, this.actors);

  @override
  _MovieDetailCastState createState() => _MovieDetailCastState();
}

class _MovieDetailCastState extends State<MovieDetailCast> {
  @override
  Widget build(BuildContext context) {
    List<MovieActorModal> casts = [];
    casts.addAll(this.widget.directors);
    casts.addAll(this.widget.actors);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '演职员',
              style: TextStyle(
                fontSize: fixedFontSize(16),
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox.fromSize(
            size: Size.fromHeight(130),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: casts.length,
              itemBuilder: (BuildContext context, int index) => buildCast(context, index, casts),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCast(BuildContext context, int index, List<MovieActorModal> casts) {
    MovieActorModal cast = casts[index];
    double paddingRight = 0;
    if (index == casts.length - 1) {
      paddingRight = 15;
    }

    return Container(
      width: 80,
      margin: EdgeInsets.only(left: 15, right: paddingRight),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (cast.id == null) {
                Toast.show('暂无该演员信息');
              } else {
                AppNavigator.pushActorDetail(context, cast.id);
              }
            },
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(cast.avatars.large),
              radius: 40,
            ),
          ),
          SizedBox(height: 8),
          Container(
            child: Text(
              cast.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fixedFontSize(14),
                color: AppColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}