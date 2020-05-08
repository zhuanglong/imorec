import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/app/api_client.dart';
import 'package:imorec/app/app_color.dart';
import 'package:imorec/home/news_banner_widget.dart';
import 'package:imorec/modal/movie_news.dart';
import 'package:imorec/home/three_grid_widget.dart';
import 'package:imorec/modal/movie_item.dart';
import 'package:imorec/util/movie_data_util.dart';

class HomeScene extends StatefulWidget {
  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State<HomeScene> with AutomaticKeepAliveClientMixin {
  List<MovieNews> _newsList;
  List<MovieItem> _hottingList;
  List<MovieItem> _comingList;

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
                NewsBannerWidget(_newsList),
                ThreeGridWidget(_hottingList, '影院热映', 'in_theaters'),
                ThreeGridWidget(_comingList, '即将上映', 'coming_soon'),
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

  // 加载数据
  Future _fetchData() async {
    ApiClient client = ApiClient();
    List<MovieNews> news = await client.getNewsList();
    var _hottingListData = await client.getHottingList(start: 0, count: 6);
    var _comingListData = await client.getComingList(start: 0, count: 6);

    setState(() {
      _newsList = news;
      _hottingList = MovieDataUtil.getMovieList(_hottingListData);
      _comingList = MovieDataUtil.getMovieList(_comingListData);
    });
  }
}
