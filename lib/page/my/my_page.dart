import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:imorec/app/app_navigator.dart';
import 'package:imorec/app/app_color.dart';
import 'package:imorec/util/screen.dart';
import 'package:imorec/util/toast.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _avatarUrl = 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3454574876,1377139334&fm=27&gp=0.jpg';

  @override
  void deactivate() {
    super.deactivate();
    print('MyPage deactivate');
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
            _buildItem('images/icon_github.png', '项目地址', _openGithub),
            _buildItem('images/icon_qq.png', 'Flutter 技术群', _copyQQNumber),
            _buildItem('images/icon_API.png', 'API 文档', _openApi),
          ],
        ),
      ),
    );
  }

  _copyQQNumber() {
    Clipboard.setData(ClipboardData(text: '693338726'));
    Toast.show('已复制 QQ 群号');
  }

  _openApi() {
    AppNavigator.pushWeb(context, 'https://github.com/Mayandev/morec/blob/master/API.md', 'Api');
  }

  _openGithub() {
    AppNavigator.pushWeb(context, 'https://github.com/Mayandev/morec', 'Morec');
  }

  Widget _buildItem(String icon, String text, onTap) {
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

  Widget _buildHeader() {
    double width = Screen.width;
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
