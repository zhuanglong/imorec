import 'package:flutter/material.dart';

import 'package:imorec/router/router.dart';
import 'package:imorec/util/utility.dart';
import 'package:imorec/modal/movie_actor_detail_modal.dart';
import 'package:imorec/widget/rating_widget.dart';
import 'package:imorec/widget/movie_cover_image_widget.dart';

class ActorDetailWorks extends StatelessWidget {
  final List<MovieActorWorkModal> works;

  ActorDetailWorks(this.works);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '影视作品',
              style: TextStyle(
                fontSize: fixedFontSize(16),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox.fromSize(
            size: Size.fromHeight(180),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: works.length,
              itemBuilder: (BuildContext context, int index) => buildWorks(context, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWorks(BuildContext context, int index) {
    double width = 90;
    MovieActorWorkModal work = works[index];
    double paddingRight = 0;
    if (index == works.length - 1) {
      paddingRight = 15;
    }

    return GestureDetector(
      onTap: () {
        Router.pushMovieDetail(context, work.movie.id);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15,right: paddingRight),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieCoverImageWidget(work.movie.images.small, width: width, height: width / 0.75),
            SizedBox(height: 5),
            Text(
              work.movie.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3),
            Row(
              children: <Widget>[
                StaticRatingBar(size: 13.0, rate: work.movie.rating.average / 2),
                SizedBox(width: 5),
                Text(
                  work.movie.rating.average.toString(),
                  style: TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}