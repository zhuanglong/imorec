import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/app/app_color.dart';
import 'package:imorec/util/screen.dart';

class MyScene extends StatefulWidget {
  @override
  _MySceneState createState() => _MySceneState();
}

class _MySceneState extends State<MyScene> {
  String avatarUrl = 'https://ws2.sinaimg.cn/large/006tKfTcly1g1jsilob3pj30oe0oi7vc.jpg';

  @override
  void deactivate() {
    super.deactivate();
    print('MyScene deactivate');
  }

  @override
  Widget build(BuildContext context) {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: Container(
        color: AppColor.white,
        height: Screen.height,
        width: Screen.width,
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[
            _buildHeader(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    double width = Screen.width;
    double height = 250;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Image(
            image: CachedNetworkImageProvider(avatarUrl),
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          Opacity(
            opacity: 0.7,
            child: Container(
              color: Colors.black,
              width: width,
              height: height,
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: width,
              height: height,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(avatarUrl),
                    radius: 50.0,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'zhuanglong',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
