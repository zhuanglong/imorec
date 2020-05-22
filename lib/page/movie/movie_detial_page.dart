import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:imorec/page/movie/widget/movie_detail_cast.dart';
import 'package:imorec/page/movie/widget/movie_detail_comment.dart';
import 'package:imorec/page/movie/widget/movie_photos.dart';
import 'package:imorec/page/movie/widget/movie_summary.dart';
import 'package:imorec/page/movie/widget/movie_detail_header.dart';
import 'package:imorec/page/movie/widget/movie_detail_tag.dart';
import 'package:imorec/common/api/api_service.dart';
import 'package:imorec/common/style/app_style.dart';
import 'package:imorec/modal/movie_detail_modal.dart';
import 'package:imorec/util/screen_util.dart';
import 'package:imorec/util/toast.dart';

class MovieDetialPage extends StatefulWidget {
  final String id;

  MovieDetialPage({this.id});

  @override
  _MovieDetialPageState createState() => _MovieDetialPageState();
}

class _MovieDetialPageState extends State<MovieDetialPage> {
  MovieDetailModal movieDetail;
  double navAlpha = 0;
  Color pageColor = AppColor.white;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  back() {
    Navigator.pop(context);
  }
  
  onMorePhotos() {
    Toast.show('开发中...');
  }

  Future fetchData() async {
    ApiService apiService = ApiService();
    MovieDetailModal data = MovieDetailModal.fromJson(
      await apiService.getMovieDetail(this.widget.id));
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(data.images.small));
    
    setState(() {
      movieDetail = data;
      if (paletteGenerator.darkVibrantColor != null) {
        pageColor = paletteGenerator.darkVibrantColor.color;
      } else {
        pageColor = Color(0xff35374c);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.updateStatusBarStyle('light');
    if (movieDetail == null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: back,
            child: Image.asset('images/icon_arrow_back_black.png'),
          ),
        ),
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: pageColor,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 0),
                    children: <Widget>[
                      MovieDetailHeader(movieDetail, pageColor),
                      MovieDetailTag(movieDetail.tags),
                      MovieSummary(movieDetail.summary),
                      MovieDetailCast(movieDetail.directors, movieDetail.casts),
                      MoviePhotos('预告片 / 剧照', movieDetail.trailers, movieDetail.photos, movieDetail.id, onMorePhotos),
                      MovieDetailComment(movieDetail.comments),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buildNavigationBar(),
        ],
      ),
    );
  }

  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Container(
          width: 44,
          height: ScreenUtil.navigationBarHeight(context),
          padding: EdgeInsets.fromLTRB(5, ScreenUtil.topSafeHeight(context), 0, 0),
          child: GestureDetector(
            onTap: back,
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            decoration: BoxDecoration(color: pageColor),
            height: ScreenUtil.navigationBarHeight(context),
            padding: EdgeInsets.fromLTRB(5, ScreenUtil.topSafeHeight(context), 0, 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(
                    onTap: back,
                    child: Image.asset('images/icon_arrow_back_white.png'),
                  ),
                ),
                Expanded(
                  child: Text(
                    movieDetail.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 44,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}