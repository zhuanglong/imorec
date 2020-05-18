import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:imorec/modal/movie_actor_detail_modal.dart';
import 'package:imorec/page/movie/widget/actor_detail_header.dart';
import 'package:imorec/page/movie/widget/actor_detail_works.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:imorec/page/movie/widget/movie_photos.dart';
import 'package:imorec/page/movie/widget/movie_summary.dart';

import 'package:imorec/app/api_client.dart';
import 'package:imorec/app/app_color.dart';
import 'package:imorec/util/screen.dart';

class ActorDetialPage extends StatefulWidget {
  final String id;

  ActorDetialPage({this.id});

  @override
  _ActorDetialPageState createState() => _ActorDetialPageState();
}

class _ActorDetialPageState extends State<ActorDetialPage> {
  MovieActorDetailModal actorDetail;
  double navAlpha = 0;
  Color pageColor = AppColor.white;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();

    scrollController.addListener(() {
      var offset = scrollController.offset;
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
  Widget build(BuildContext context) {
    Screen.updateStatusBarStyle('light');
    if (actorDetail == null) {
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
            color: pageColor,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 0),
                    children: <Widget>[
                      ActorDetailHeader(actorDetail, pageColor),
                      MovieSummary(actorDetail.summary),
                      ActorDetailWorks(actorDetail.works),
                      MoviePhotos('相册', [], actorDetail.photos, actorDetail.id, onMorePhotos),
                    ],
                  ),
                ),
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
          height: Screen.navigationBarHeight,
          padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
          child: GestureDetector(
            onTap: onBack,
            child: Image.asset('images/icon_arrow_back_white.png'),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            decoration: BoxDecoration(color: pageColor),
            height: Screen.navigationBarHeight,
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(
                    onTap: onBack,
                    child: Image.asset('images/icon_arrow_back_white.png'),
                  ),
                ),
                Expanded(
                  child: Text(
                    actorDetail.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(width: 44),
              ],
            ),
          ),
        ),
      ],
    );
  }

  onBack() {
    Navigator.pop(context);
  }
  
  onMorePhotos() {

  }

  Future fetchData() async {
    ApiClient client = ApiClient();
    MovieActorDetailModal data = MovieActorDetailModal.fromJson(
        await client.getActorDetail(this.widget.id));
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(data.avatars.small));
    
    setState(() {
      actorDetail = data;
      if (paletteGenerator.darkMutedColor != null) {
        pageColor = paletteGenerator.darkMutedColor.color;
      } else {
        pageColor = Color(0xff35374c);
      }
    });
  }
}