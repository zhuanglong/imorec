import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/app.dart' show routeObserver;
import 'package:imorec/common/api/api_service.dart';
import 'package:imorec/common/style/app_style.dart';
import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/page/movie/widget/movie_list_item.dart';
import 'package:imorec/page/movie/widget/movie_top_item.dart';
import 'package:imorec/util/movie_data_util.dart';
import 'package:imorec/util/screen_util.dart';

class MovieTopListPage extends StatefulWidget {
  final String action;
  final String title;
  final String subTitle;
  
  MovieTopListPage(this.action, this.title, this.subTitle);

  @override
  _MovieTopListPageState createState() => _MovieTopListPageState();
}

class _MovieTopListPageState extends State<MovieTopListPage> with RouteAware {
  ScrollController scrollController = ScrollController();
  List<MovieItemModal> movieList = [];
  double navAlpha = 0;
  bool isVisible = true;
  bool loaded = false;
  int start = 0;
  int count = 25;

  double coverWidth = ScreenUtil.width;
  double coverHeight = 218 + ScreenUtil.topSafeHeight;

  @override
  void initState() {
    super.initState();
    fetchData();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        fetchData();
      }

      double offset = scrollController.offset;
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    isVisible = true;
    updateStatusBar();
  }

  @override
  didPush() {
    Timer(Duration(milliseconds: 500), () {
      updateStatusBar();
    });
  }

  @override
  void didPop() {
    isVisible = false;
  }

  @override
  void didPushNext() {
    isVisible = false;
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    scrollController.dispose();
    super.dispose();
  }

  onBack() {
    Navigator.pop(context);
  }

  updateStatusBar() {
    if (navAlpha == 1) {
      ScreenUtil.updateStatusBarStyle('dark');
    } else {
      ScreenUtil.updateStatusBarStyle('light');
    }
  }

  Future fetchData() async {
    if (loaded) return;

    var data;
    String action = this.widget.action;
    ApiService apiService = ApiService();
    switch (action) {
      case 'weekly':
        data = await apiService.getWeeklyList();
        break;
      case 'new_movies':
        data = await apiService.getNewMovieList();
        break;
      case 'us_box':
        data = await apiService.getUsBoxList();
        break;
      case 'top250':
        data = await apiService.getTop250List(start: start, count: count);
        break;
      default:
        break;
    }
    List<MovieItemModal> newMovies = MovieDataUtil.getMovieList(data);

    setState(() {
      movieList.addAll(newMovies);
      if (action == 'top250') {
        if (newMovies.length == 0) {
          loaded = true;
          return;
        }
      } else {
        loaded = true;
        return;
      }
      start = start + count;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isVisible) {
      updateStatusBar();
    }

    if (movieList.length == 0) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: onBack,
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
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 0),
              children: <Widget>[
                buildHeader(),
                buildList(),
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
          height: ScreenUtil.navigationBarHeight,
          padding: EdgeInsets.fromLTRB(5, ScreenUtil.topSafeHeight, 0, 0),
          child: GestureDetector(
            onTap: onBack,
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            color: AppColor.white,
            height: ScreenUtil.navigationBarHeight,
            padding: EdgeInsets.fromLTRB(5, ScreenUtil.topSafeHeight, 0, 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(
                    onTap: onBack,
                    child: Image.asset('images/icon_arrow_back_black.png'),
                  ),
                ),
                Expanded(
                  child: Text(
                    this.widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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

  Widget buildHeader() {
    return Container(
      width: coverWidth,
      height: coverHeight,
      child: Stack(
        children: <Widget>[
          Image(
            image: CachedNetworkImageProvider(movieList[0].images.large),
            fit: BoxFit.cover,
            width: coverWidth,
            height: coverHeight,
          ),
          Container(color: Color(0xbb000000)),
          ClipRRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: coverWidth,
                height: coverHeight,
                padding: EdgeInsets.fromLTRB(30, 0, 10, 20),
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.widget.subTitle,
                      style: TextStyle(color: AppColor.white),
                    ),
                    SizedBox(height: 20),
                    Text(
                      this.widget.title,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList() {
    int index = 1;
    List<Widget> children = [];
    for (var i = 0; i < movieList.length; i++) {
      children.add(MovieTopItem(index: index++, item: MovieListItem(movieList[i], this.widget.action)));
    }
    Widget loading = Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Offstage(
        offstage: loaded,
        child: CupertinoActivityIndicator(),
      ),
    );
    children.add(loading);
    return Column(
      children: children,
    );
  }
}