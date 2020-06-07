import 'package:flutter/material.dart';

import 'package:imorec/page/home/widget/section_bar.dart';
import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/util/device_util.dart';
import 'package:imorec/router/router.dart';
import 'package:imorec/widget/rating_widget.dart';
import 'package:imorec/widget/movie_cover_image_widget.dart';

class ThreeGrid extends StatelessWidget {
  final List<MovieItemModal> movies;
  final String title;
  final String action;

  ThreeGrid(this.movies, this.title, this.action);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    switch(title) {
      case '影院热映':
        children = movies.map((movie) => buildHotting(context, movie)).toList();
        break;
      case '即将上映':
        children = movies.map((movie) => buildComing(context, movie)).toList();
        break;
    }

    return Container(
      child: Column(
        children: <Widget>[
          SectionBar(title, action),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Wrap(spacing: 15, runSpacing: 20, children: children),
          ),
          Container(height: 10),
        ],
      ),
    );
  }

  Widget buildCoverWithTitle(BuildContext context, {MovieItemModal movie, Widget child}) {
    final double coverImageWidth = (DeviceUtil.width(context) - 15 * 4) / 3;
    return GestureDetector(
      onTap: () {
        Router.pushMovieDetail(context, movie.id);
      },
      child: Container(
        width: coverImageWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieCoverImageWidget(movie.images.small, width: coverImageWidth, height: coverImageWidth / 0.75),
            SizedBox(height: 5),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3),
            child,
          ],
        ),
      ),
    );
  }

  Widget buildHotting(BuildContext context, MovieItemModal movie) {
    return buildCoverWithTitle(
      context,
      movie: movie,
      child: Row(
        children: <Widget>[
          StaticRatingBar(size: 13.0, rate: movie.rating.average / 2),
          SizedBox(width: 5),
          Text(
            movie.rating.average.toString(),
            style: TextStyle(
              color: Color(0xFF888888),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComing(BuildContext context, MovieItemModal movie) {
    return buildCoverWithTitle(
      context,
      movie: movie,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${movie.collectCount}人想看',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF888888),
            ),
          ),
          SizedBox(height: 3),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 0.5),
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Text(
              '${movie.mainlandPubdate.split('-')[1]}月${movie.mainlandPubdate.split('-')[2]}日',
              style: TextStyle(
                color: Colors.red,
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}