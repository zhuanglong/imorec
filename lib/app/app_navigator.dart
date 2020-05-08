import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/widget/web_view_widget.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => scene),
    );
  }

  // webview
  static pushWeb(BuildContext context, String url, String title) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) {
        return WebViewWidget(url: url, title: title);
      }),
    );
  }
}