import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/app/app_color.dart';
import 'package:imorec/app/app_navigator.dart';
import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/widget/movie_cover_image_widget.dart';
import 'package:imorec/widget/rating_widget.dart';
import 'package:imorec/page/movie/widget/join_string.dart';

class MovieListItem extends StatelessWidget {
  final MovieItemModal movie;
  final String actionStr;

  MovieListItem(this.movie, this.actionStr);

  @override
  Widget build(BuildContext context) {
    double imgWidth = 100;
    double height = imgWidth / 0.7;
    double spaceWidth = 15;
    double actionWidth = 60;

    return GestureDetector(
      onTap: () {
        AppNavigator.pushMovieDetail(context, movie.id);
      },
      child: Container(
        padding: EdgeInsets.all(spaceWidth),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColor.lightGrey, width: 0.5),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            MovieCoverImageWidget(
              movie.images.small,
              width: imgWidth,
              height: height,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(spaceWidth, 0, spaceWidth, 0),
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        StaticRatingBar(
                          size: 13.0,
                          rate: movie.rating.average / 2,
                        ),
                        SizedBox(width: 5),
                        Text(
                          movie.rating.average.toString(),
                          style: TextStyle(color: AppColor.grey, fontSize: 12.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${movie.year} /${genres2String(movie.genres)}/${actor2String(movie.directors)}/${actor2String(movie.casts)}',
                      style: TextStyle(color: AppColor.grey, fontSize: 14.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: actionWidth,
              height: height,
              child: Center(child: _buildAction()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction() {
    Widget action;
    String pubdate = movie.mainlandPubdate;

    if (pubdate != '') {
      pubdate = movie.mainlandPubdate.split('-')[1] +
          '月\n' +
          movie.mainlandPubdate.split('-')[2] +
          '日';
    } else {
      pubdate = '待定';
    }

    switch (actionStr) {
      case 'coming_soon':
        action = Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Text(
            pubdate,
            style: TextStyle(color: Colors.red, fontSize: 12.0),
          ),
        );
        break;
      default:
        action = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              color: Color(0xFFF7AC3A),
              onPressed: () {},
            ),
            Text('收藏', style: TextStyle(color: Color(0xFFF7AC3A))),
          ],
        );
        break;
    }

    return action;
  }
}