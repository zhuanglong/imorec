import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/common/style/app_style.dart';
import 'package:imorec/modal/movie_photo_modal.dart';
import 'package:imorec/modal/movie_trailer_modal.dart';
import 'package:imorec/util/navigator_util.dart';
import 'package:imorec/util/utility.dart';

const double boxWidth = 160;
const double boxHeight = 120;
const EdgeInsets boxInterval = EdgeInsets.only(left: 15, bottom: 15);

class MoviePhotos extends StatelessWidget {
  final String sectionTitle;
  final List<MovieTrailerModal> trailers;
  final List<MoviePhotoModal> photos;
  final String movieId;
  final VoidCallback onMore;

  MoviePhotos(this.sectionTitle, this.trailers, this.photos, this.movieId, this.onMore);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    List<String> imageUrls = [];
    List<ImageProvider> providers = [];
    for (var i = 0; i < trailers.length; i++) {
      children.add(TrailerItem(trailers[i]));
    }
    for (var i = 0; i < photos.length; i++) {
      imageUrls.add(photos[i].image);
    }
    for (var i = 0; i < photos.length; i++) {
      children.add(PhotoItem(photos[i], i, providers, imageUrls));
      providers.add(CachedNetworkImageProvider(photos[i].image));
    }

    if (children.length == 0) {
      children.add(buildNull());
    } else {
      children.add(buildShowMore());
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              sectionTitle,
              style: TextStyle(
                fontSize: fixedFontSize(16),
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox.fromSize(
            size: Size.fromHeight(120),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNull() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Text(
        '暂无相册',
        style: TextStyle(color: AppColor.white, fontSize: fixedFontSize(14)),
      ),
    );
  }

  Widget buildShowMore() {
    return Container(
      margin: boxInterval,
      child: GestureDetector(
        onTap: this.onMore,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '查看更多',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.lightGrey,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: AppColor.lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}

class TrailerItem extends StatelessWidget {
  final MovieTrailerModal trailer;

  TrailerItem(this.trailer);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: boxInterval,
      child: GestureDetector(
        onTap: () {
           NavigatorUtil.pushVideoPlay(context, trailer.trailerUrl);
        },
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image(
                image: CachedNetworkImageProvider(trailer.cover),
                width: boxWidth,
                height: boxHeight,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: boxWidth,
              height: boxHeight,
              child: Center(
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Icon(Icons.play_arrow, color:AppColor.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhotoItem extends StatelessWidget {
  final MoviePhotoModal photo;
  final int index;
  final List<ImageProvider> providers;
  final List<String> imageUrls;

  PhotoItem(this.photo, this.index, this.providers, this.imageUrls);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: boxInterval,
      child: GestureDetector(
        onTap: () {
          NavigatorUtil.pushPhtotPreview(context, providers, index, imageUrls);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Hero(
            tag: 'photo$index',
            child: Image(
              image: CachedNetworkImageProvider(photo.icon),
              width: boxWidth,
              height: boxHeight,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}