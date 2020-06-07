import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/widget/movie_cover_image_widget.dart';
import 'package:imorec/widget/rating_widget.dart';
import 'package:imorec/router/router.dart';
import 'package:imorec/util/movie_data_util.dart';
import 'package:imorec/provider/theme_provider.dart';

class MovieListItem extends StatelessWidget {
  final MovieItemModal movie;
  final String actionStr;

  MovieListItem(this.movie, this.actionStr);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.select((ThemeProvider themeProvider) => themeProvider);
  
    double imgWidth = 100;
    double height = imgWidth / 0.7;
    double spaceWidth = 15;
    double actionWidth = 60;

    return GestureDetector(
      onTap: () {
        Router.pushMovieDetail(context, movie.id);
      },
      child: Container(
        padding: EdgeInsets.all(spaceWidth),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: themeProvider.theme['itemSeparatorColor'], width: 0.5),
          ),
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
                          style: TextStyle(color: Color(0xFF888888), fontSize: 12.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${movie.year} /${MovieDataUtil.genres2String(movie.genres)}/${MovieDataUtil.actor2String(movie.directors)}/${MovieDataUtil.actor2String(movie.casts)}',
                      style: TextStyle(color: Color(0xFF888888), fontSize: 14.0),
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
              child: Center(child: buildAction()),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAction() {
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