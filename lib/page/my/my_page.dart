import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/common/style/app_style.dart';
import 'package:imorec/util/navigator_util.dart';
import 'package:imorec/util/screen_util.dart';
import 'package:imorec/util/toast.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _avatarUrl = 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3454574876,1377139334&fm=27&gp=0.jpg';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.updateStatusBarStyle('light');
    return Scaffold(
      body: Container(
        color: AppColor.white,
        height: ScreenUtil.height,
        width: ScreenUtil.width,
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[
            buildHeader(),
            buildItem('images/icon_github.png', '项目地址', openGithub),
            buildItem('images/icon_qq.png', 'Flutter 技术群', copyQQNumber),
            buildItem('images/icon_API.png', 'API 文档', openApi),
          ],
        ),
      ),
    );
  }

  copyQQNumber() {
    Clipboard.setData(ClipboardData(text: '123xxxxx'));
    Toast.show('已复制 QQ 群号');
  }

  openApi() {
    NavigatorUtil.pushWeb(context, 'https://github.com/Mayandev/morec/blob/master/API.md', 'Api');
  }

  openGithub() {
    NavigatorUtil.pushWeb(context, 'https://github.com/zhuanglong/imorec', 'Morec');
  }

  Widget buildItem(String icon, String text, onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColor.lightGrey, width: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    icon,
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 20),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    double width = ScreenUtil.width;
    double height = 250;
    return ClipRect(
      child: Stack(
        children: <Widget>[
          Image(
            image: CachedNetworkImageProvider(_avatarUrl),
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
                    backgroundImage: CachedNetworkImageProvider(_avatarUrl),
                    radius: 40.0,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hello',
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
