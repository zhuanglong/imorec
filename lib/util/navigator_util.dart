import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/page/movie/movie_top_list_page.dart';
import 'package:imorec/page/setting/language_page.dart';
import 'package:imorec/page/setting/theme_page.dart';

import 'package:imorec/widget/web_view_widget.dart';
import 'package:imorec/page/movie/movie_list_page.dart';
import 'package:imorec/page/movie/movie_detial_page.dart';
import 'package:imorec/page/movie/actor_detial_page.dart';
import 'package:imorec/page/movie/movie_photo_preview_page.dart';
import 'package:imorec/page/movie/movie_video_play_page.dart';
import 'package:imorec/page/setting/setting_page.dart';

class NavigatorUtil {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => scene),
    );
  }

  static back(BuildContext context) {
    Navigator.pop(context);
  }

  // 电影列表
  static pushMovieList(BuildContext context, String title, String action) {
    NavigatorUtil.push(context, MovieListPage(title: title, action: action));
  }

  // 电影详情
  static pushMovieDetail(BuildContext context, String id) {
    NavigatorUtil.push(context, MovieDetialPage(id: id));
  }

  // 演员详情
  static pushActorDetail(BuildContext context, String id) {
    NavigatorUtil.push(context, ActorDetialPage(id: id));
  }

  // 图片预览
  static pushPhtotPreview(BuildContext context, providers, index, imageUrls) {
    NavigatorUtil.push(context, MoviePhotoPreviewPage(providers, index, imageUrls));
  }

  // 播放视频
  static pushVideoPlay(BuildContext context, String url) {
    NavigatorUtil.push(context, MovieVideoPlayPage(url));
  }

  // 电影榜单列表
  static pushMovieTopList(BuildContext context, String action, String title, String subTitle) {
    NavigatorUtil.push(context, MovieTopListPage(action, title, subTitle));
  }

  // 设置
  static pushSettingPage(BuildContext context) {
    NavigatorUtil.push(context, SettingPage());
  }

  // 主题
  static pushThemePage(BuildContext context) {
    NavigatorUtil.push(context, ThemePage());
  }

  // 语言
  static pushLanguagePage(BuildContext context) {
    NavigatorUtil.push(context, LanguagePage());
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