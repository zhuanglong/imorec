import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/common/style/app_style.dart';
import 'package:imorec/modal/movie_detail_modal.dart';
import 'package:imorec/util/screen_util.dart';
import 'package:imorec/util/utility.dart';
import 'package:imorec/util/movie_data_util.dart';
import 'package:imorec/widget/movie_cover_image_widget.dart';
import 'package:imorec/widget/rating_widget.dart';

class MovieDetailHeader extends StatelessWidget {
  final MovieDetailModal movieDetail;
  final Color coverColor;

  MovieDetailHeader(this.movieDetail, this.coverColor);

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil.width;
    double heihgt = 218 + ScreenUtil.topSafeHeight;

    return Container(
      width: width,
      height: heihgt,
      child: Stack(
        children: <Widget>[
          Image(
            image: CachedNetworkImageProvider(movieDetail.photos[0].image),
            fit: BoxFit.cover,
            width: width,
            height: heihgt,
          ),
          Opacity(
            opacity: 0.7,
            child: Container(
              color: coverColor,
              width: width,
              height: heihgt,
            ),
          ),
          Container(
            width: width,
            height: heihgt,
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(15, 54 + ScreenUtil.topSafeHeight, 10, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x66000000),
                        offset: Offset(1.0, 1.0),
                        blurRadius: 5.0,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: MovieCoverImageWidget(movieDetail.images.large, width: 100, height: 133),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        movieDetail.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fixedFontSize(20),
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        movieDetail.originalTitle + '（${movieDetail.year}）',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fixedFontSize(16),
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          StaticRatingBar(size: 13.0, rate: movieDetail.rating.average / 2),
                          SizedBox(width: 5),
                          Text(
                            movieDetail.rating.average.toString(),
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: fixedFontSize(12)
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${MovieDataUtil.countries2String(movieDetail.countries)}/${MovieDataUtil.list2String(movieDetail.genres)}/ 上映时间：${MovieDataUtil.list2String(movieDetail.pubdates)}/ 片长：${MovieDataUtil.list2String(movieDetail.durations)}/${MovieDataUtil.actor2String(movieDetail.directors)}/${MovieDataUtil.actor2String(movieDetail.casts)}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: fixedFontSize(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}