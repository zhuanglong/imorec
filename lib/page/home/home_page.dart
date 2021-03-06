import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:imorec/common/i18n/app_localizations.dart';
import 'package:imorec/page/home/widget/three_grid.dart';
import 'package:imorec/page/home/widget/news_banner.dart';
import 'package:imorec/page/home/widget/top_banner.dart';
import 'package:imorec/common/api/api_service.dart';
import 'package:imorec/modal/movie_news_modal.dart';
import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/provider/theme_provider.dart';
import 'package:imorec/util/movie_data_util.dart';
import 'package:imorec/util/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<MovieNewsModal> newsList;
  List<MovieItemModal> hottingList;
  List<MovieItemModal> comingList;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // 保存页面状态，防止 tabbar 切换导致 widget 销毁
  @override
  bool get wantKeepAlive => true;

  // 加载数据
  Future fetchData() async {
    ApiService apiService = ApiService();
    List<MovieNewsModal> news = await apiService.getNewsList();
    var hottingListData = await apiService.getHottingList(start: 0, count: 6);
    var comingListData = await apiService.getComingList(start: 0, count: 6);

    setState(() {
      newsList = news;
      hottingList = MovieDataUtil.getMovieList(hottingListData);
      comingList = MovieDataUtil.getMovieList(comingListData);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.i18n(context).homeTitle,
          style: TextStyle(
            color: context.select((ThemeProvider themeProvider) => themeProvider.theme['navTitleColor']),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Toast.show('开发中...');
            },
          ),
        ],
      ),
      body: newsList == null ?
        Center(
          child: CupertinoActivityIndicator(),
        ) :
        Container(
          child: RefreshIndicator(
            onRefresh: fetchData,
            child: ListView(
              addAutomaticKeepAlives: true,
              // 防止 children 被重绘
              cacheExtent: 10000,
              children: <Widget>[
                NewsBanner(newsList),
                ThreeGrid(hottingList, '影院热映', 'in_theaters'),
                ThreeGrid(comingList, '即将上映', 'coming_soon'),
                TopBanner('电影榜单'),
              ],
            ),
          ),
        ),
    );
  }
}
