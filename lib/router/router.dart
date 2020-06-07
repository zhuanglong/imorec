import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/router/router_test.dart';
import 'package:imorec/widget/web_view_widget.dart';
import 'package:imorec/page/movie/movie_top_list_page.dart';
import 'package:imorec/page/setting/language_page.dart';
import 'package:imorec/page/setting/theme_page.dart';
import 'package:imorec/page/movie/movie_list_page.dart';
import 'package:imorec/page/movie/movie_detial_page.dart';
import 'package:imorec/page/movie/actor_detial_page.dart';
import 'package:imorec/page/movie/movie_photo_preview_page.dart';
import 'package:imorec/page/movie/movie_video_play_page.dart';
import 'package:imorec/page/setting/setting_page.dart';
import 'package:imorec/page/tabbar/tabbar_page.dart';

class Router {
  // 路由配置，用于路由名跳转方式
  static final routes = <String, WidgetBuilder>{
    '/router-test': (BuildContext context) => RouterTest(),
  };

  // 用于测试路由跳转
  static pushTestPage(BuildContext context) {
    // 跳转方式1
    // 这种方式要传入 Widget。
    // Navigator.push(
    //   context,
    //   CupertinoPageRoute(builder: (BuildContext context) => RouterTest(title: 'myTitle', content: 'myContent')),
    // );

    // 跳转方式2
    // 这种方式需要在 MaterialApp 中定义好 routes；
    // 接收传递的参数 final String args = ModalRoute.of(context).settings.arguments;
    // 不能在 initState 中使用 ModalRoute.of(context).settings.arguments。
    
    // 这两种方式对比，推荐第一种，传参较方便，也不同定义路由名。

    // Navigator.pushNamed(
    //   context,
    //   '/router-test',
    //   arguments: {'title': 'myTitle', 'content': 'myContent'},
    // );
  }

  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => scene),
    );
  }

  static replace(BuildContext context, Widget scene) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => scene),
    );
  }

  static back(BuildContext context) {
    Navigator.pop(context);
  }

  // webview
  static pushWeb(BuildContext context, String url, String title) {
    Router.push(context, WebViewWidget(url: url, title: title));
  }

  // 首页
  static pushTabbarPage(BuildContext context) {
    Router.replace(context, TabbarPage());
  }

  // 电影列表
  static pushMovieList(BuildContext context, String title, String action) {
    Router.push(context, MovieListPage(title: title, action: action));
  }

  // 电影详情
  static pushMovieDetail(BuildContext context, String id) {
    Router.push(context, MovieDetialPage(id: id));
  }

  // 演员详情
  static pushActorDetail(BuildContext context, String id) {
    Router.push(context, ActorDetialPage(id: id));
  }

  // 图片预览
  static pushPhtotPreview(BuildContext context, providers, index, imageUrls) {
    Router.push(context, MoviePhotoPreviewPage(providers, index, imageUrls));
  }

  // 播放视频
  static pushVideoPlay(BuildContext context, String url) {
    Router.push(context, MovieVideoPlayPage(url));
  }

  // 电影榜单列表
  static pushMovieTopList(BuildContext context, String action, String title, String subTitle) {
    Router.push(context, MovieTopListPage(action, title, subTitle));
  }

  // 设置
  static pushSettingPage(BuildContext context) {
    Router.push(context, SettingPage());
  }

  // 主题
  static pushThemePage(BuildContext context) {
    Router.push(context, ThemePage());
  }

  // 语言
  static pushLanguagePage(BuildContext context) {
    Router.push(context, LanguagePage());
  }
}