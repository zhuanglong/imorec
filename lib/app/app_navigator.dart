import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/widget/web_view_widget.dart';
import 'package:imorec/page/movie/movie_list_page.dart';
import 'package:imorec/page/movie/movie_detial_page.dart';

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