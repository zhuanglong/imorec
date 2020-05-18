import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:imorec/page/movie/widget/movie_detail_cast.dart';
import 'package:imorec/page/movie/widget/movie_detail_comment.dart';
import 'package:imorec/page/movie/widget/movie_photos.dart';
import 'package:imorec/page/movie/widget/movie_summary.dart';

import 'package:imorec/app/api_client.dart';
import 'package:imorec/app/app_color.dart';
import 'package:imorec/modal/movie_detail_modal.dart';
import 'package:imorec/util/screen.dart';
import 'package:imorec/page/movie/widget/movie_detail_header.dart';
import 'package:imorec/page/movie/widget/movie_detail_tag.dart';

class MovieDetialPage extends StatefulWidget {
  final String id;

  MovieDetialPage({this.id});

  @override
  _MovieDetialPageState createState() => _MovieDetialPageState();
}

class _MovieDetialPageState extends State<MovieDetialPage> {
  MovieDetailModal _movieDetail;
  double _navAlpha = 0;
  Color _pageColor = AppColor.white;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(() {
      var offset = _scrollController.offset;
      if (offset < 0) {
        if (_navAlpha != 0) {
          setState(() {
            _navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          _navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (_navAlpha != 1) {
        setState(() {
          _navAlpha = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Screen.updateStatusBarStyle('light');
    if (_movieDetail == null) {
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
            color: _pageColor,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.only(top: 0),
                    children: <Widget>[
                      MovieDetailHeader(_movieDetail, _pageColor),
                      MovieDetailTag(_movieDetail.tags),
                      MovieSummary(_movieDetail.summary),
                      MovieDetailCast(_movieDetail.directors, _movieDetail.casts),
                      MoviePhotos('预告片 / 剧照', _movieDetail.trailers, _movieDetail.photos, _movieDetail.id, onMorePhotos),
                      MovieDetailComment(_movieDetail.comments),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Container(
          width: 44,
          height: Screen.navigationBarHeight,
          padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
          child: GestureDetector(
            onTap: back,
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        Opacity(
          opacity: _navAlpha,
          child: Container(
            decoration: BoxDecoration(color: _pageColor),
            height: Screen.navigationBarHeight,
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
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
                    _movieDetail.title,
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

  back() {
    Navigator.pop(context);
  }
  
  onMorePhotos() {

  }

  Future _fetchData() async {
    ApiClient client = ApiClient();
    MovieDetailModal data = MovieDetailModal.fromJson(
      await client.getMovieDetail(this.widget.id));
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(data.images.small));
    
    setState(() {
      _movieDetail = data;
      if (paletteGenerator.darkVibrantColor != null) {
        _pageColor = paletteGenerator.darkVibrantColor.color;
      } else {
        _pageColor = Color(0xff35374c);
      }
    });
  }
}