import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:imorec/common/api/api_service.dart';
import 'package:imorec/router/router.dart';
import 'package:imorec/util/movie_data_util.dart';
import 'package:imorec/util/device_util.dart';
import 'package:imorec/page/home/widget/section_bar.dart';
import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/modal/movie_top_banner_modal.dart';
import 'package:imorec/widget/rating_widget.dart';

class TopBanner extends StatefulWidget {
  final String title;

  TopBanner(this.title);

  @override
  _TopBannerState createState() => _TopBannerState();
}

class _TopBannerState extends State<TopBanner> {
  List<MovieTopBannerModal> banners;
  List<MovieItemModal> weeklyList, top250List, usBoxList, newMovieList;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    ApiService apiService = ApiService();
    var weeklyData = MovieDataUtil.getMovieList(await apiService.getWeeklyList());
    var top250Data = MovieDataUtil.getMovieList(await apiService.getTop250List(start: 0, count: 10));
    var usBoxData = MovieDataUtil.getMovieList(await apiService.getUsBoxList());
    var newMovieData = MovieDataUtil.getMovieList(await apiService.getNewMovieList());
    
    PaletteGenerator paletteGenerator1 = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(weeklyData[0].images.small));
      PaletteGenerator paletteGenerator2 = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(top250Data[0].images.small));
      PaletteGenerator paletteGenerator3 = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(newMovieData[0].images.small));
      PaletteGenerator paletteGenerator4 = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(usBoxData[0].images.small));

    setState(() {
      weeklyList = weeklyData;
      top250List = top250Data;
      usBoxList = usBoxData;
      newMovieList = newMovieData;
      banners = [
        MovieTopBannerModal(weeklyList, '一周口碑电影榜', '每周五更新·共10部', 'weekly', paletteGenerator1.darkVibrantColor),
        MovieTopBannerModal(top250List, '豆瓣电影Top250', '豆瓣榜单·共250部', 'top250', paletteGenerator2.darkVibrantColor),
        MovieTopBannerModal(newMovieList, '一周新电影榜', '每周五更新·共10部', 'new_movies', paletteGenerator3.darkVibrantColor),
        MovieTopBannerModal(usBoxList, '北美电影票房榜', '每周五更新·共10部', 'us_box', paletteGenerator4.darkVibrantColor),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SectionBar(this.widget.title),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: buildBanner(),
          ),
          Container(height: 10),
        ],
      ),
    );
  }

  Widget buildRank(List<MovieItemModal> movies, int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 100,
            child: Text(
              '${index + 1}. ${movies[index].title}',
              style: TextStyle(color: Colors.white, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: <Widget>[
              StaticRatingBar(size: 10.0, rate: movies[index].rating.average / 2),
              SizedBox(width: 10),
              Text(
                '${movies[index].rating.average}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBannerItem(List<MovieItemModal> movies, String title, String subTitle, PaletteColor coverColor) {
    final Radius circularValue = Radius.circular(5);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(movies[0].images.medium),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(topLeft: circularValue, topRight: circularValue),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(topLeft: circularValue, topRight: circularValue),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        subTitle,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: coverColor == null ? Color(0xff3E454D) : coverColor.color,
                borderRadius: BorderRadius.only(bottomLeft: circularValue, bottomRight: circularValue),
              ),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) => buildRank(movies, index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBanner() {
    if (banners == null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Color(0xff3E454D),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        width: DeviceUtil.width(context),
        height: DeviceUtil.width(context) * 9 / 15,
      );
    }
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 15 / 9,
        ),
        items: banners.map((banner) =>
          GestureDetector(
            onTap: () {
              Router.pushMovieTopList(context, banner.action, banner.title, banner.subTitle);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: buildBannerItem(banner.movies, banner.title, banner.subTitle, banner.coverColor),
            ),
          ),
        ).toList(),
      ),
    );
  }
}