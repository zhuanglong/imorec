import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/util/navigator_util.dart';
import 'package:imorec/modal/movie_news_modal.dart';

class NewsBanner extends StatelessWidget {
  final List<MovieNewsModal> newsList;

  NewsBanner(this.newsList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          enlargeCenterPage: true,
        ),
        items: newsList.map((item) =>
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            child: GestureDetector(
              onTap: () {
                NavigatorUtil.pushWeb(context, item.link, item.title);
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(item.cover),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          item.summary,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }
}