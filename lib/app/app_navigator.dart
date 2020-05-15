import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/widget/web_view_widget.dart';
import 'package:imorec/page/movie/movie_list_page.dart';
import 'package:imorec/page/movie/movie_detial_page.dart';
import 'package:imorec/page/movie/actor_detial_page.dart';
import 'package:imorec/page/movie/movie_photo_preview_page.dart';
import 'package:imorec/page/movie/movie_video_play_page.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => scene),
    );
  }

  // 电影列表
  static pushMovieList(BuildContext context, String title, String action) {
    AppNavigator.push(context, MovieListPage(title: title, action: action));
  }

  // 电影详情
  static pushMovieDetail(BuildContext context, String id) {
    AppNavigator.push(context, MovieDetialPage(id: id));
  }

  // 演员详情
  static pushActorDetail(BuildContext context, String id) {
    AppNavigator.push(context, ActorDetialPage(id: id));
  }

  // 图片预览
  static pushPhtotPreview(BuildContext context, providers, index, imageUrls) {
    AppNavigator.push(context, MoviePhotoPreviewPage(providers, index, imageUrls));
  }

  // 播放视频
  static pushVideoPlay(BuildContext context, String url) {
    AppNavigator.push(context, MovieVideoPlayPage(url));
  }

  // webview
  static pushWeb(BuildContext context, String url, String title) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) {
        return WebViewWidget(url: url, title: title);
      }),
    );
  }
}