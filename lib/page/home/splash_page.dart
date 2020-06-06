import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flustars/flustars.dart';

import 'package:imorec/common/constant.dart';
import 'package:imorec/provider/theme_provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0; // 是否第一次运行

  @override
  void initState() {
    super.initState();
    if (SpUtil.getBool(Constant.key_guide, defValue: true)) {
      SpUtil.putBool(Constant.key_guide, false);
      // 1500ms 显示闪屏，然后再 1500s 显示欢迎页。
      Future.delayed(Duration(milliseconds: 1500), () {
        setState(() {
          _status = 1;
        });
        Future.delayed(Duration(milliseconds: 1500), goHomePage);
      });
    } else {
      Future.delayed(Duration(milliseconds: 1500), goHomePage);
    }
  }

  void goHomePage() {
    Navigator.of(context).pushReplacementNamed('/TabbarPage');
  }

  void goLoginPage() {
    // 跳转到登陆页
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.select((ThemeProvider themeProvider) => themeProvider);
    return Material(
      color: themeProvider.theme['backgroundColor'],
      child: _status == 0 ?
        Center(
          child: Text(
            'iMorec',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ) :
        Center(
          child: Text(
            'Hi，第一次见面！',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
    );
  }
}