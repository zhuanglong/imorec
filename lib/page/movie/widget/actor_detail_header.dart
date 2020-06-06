import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/modal/movie_actor_detail_modal.dart';
import 'package:imorec/util/device_util.dart';


class ActorDetailHeader extends StatelessWidget {
  final MovieActorDetailModal actorDetail;
  final Color coverColor;

  ActorDetailHeader(this.actorDetail, this.coverColor);

  @override
  Widget build(BuildContext context) {
    double width = DeviceUtil.width(context);
    double heihgt = 218 + DeviceUtil.topSafeHeight(context);

    return Container(
      width: width,
      height: heihgt,
      child: Stack(
        children: <Widget>[
          Image(
            image: CachedNetworkImageProvider(actorDetail.photos.length == 0 ? actorDetail.avatars.large : actorDetail.photos[0].image),
            fit: BoxFit.cover,
            width: width,
            height: heihgt,
          ),
          Opacity(
            opacity: 0.7,
            child: Container(
              color: coverColor,
              width: width,
              height: heihgt,
            ),
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                width: width,
                height: heihgt,
                padding: EdgeInsets.only(top: DeviceUtil.topSafeHeight(context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(actorDetail.avatars.large),
                      radius: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      actorDetail.name,
                      style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
}