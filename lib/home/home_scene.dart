import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/app/api_client.dart';
import 'package:imorec/app/app_color.dart';
import 'package:imorec/home/movie_news_banner.dart';
import 'package:imorec/modal/movie_news.dart';

class HomeScene extends StatefulWidget {
  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State<HomeScene> with AutomaticKeepAliveClientMixin {
  int pageIndex = 0;
  List<MovieNews> _newsList;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_newsList == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text('首页'),
          backgroundColor: AppColor.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: RefreshIndicator(
            color: AppColor.primary,
            onRefresh: _fetchData,
            child: ListView(
              addAutomaticKeepAlives: true,
              // 防止 children 被重绘
              cacheExtent: 10000,
              children: <Widget>[
                NewsBannerView(_newsList),
              ],
            ),
          ),
        ),
      );
    }
  }

  // 保存页面状态，防止 tabbar 切换导致 widget 销毁
  @override
  bool get wantKeepAlive => true;

  Future _fetchData() async {
    ApiClient client = ApiClient();
    List<MovieNews> news = await client.getNewsList();
    setState(() {
      _newsList = news;
    });
  }
}
