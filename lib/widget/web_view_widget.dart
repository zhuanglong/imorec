import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:share/share.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:imorec/util/screen_util.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  final String title;

  WebViewWidget({@required this.url, this.title});

  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  void dispose() {
    ScreenUtil.updateStatusBarStyle('light');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: this.widget.url,
      appBar: AppBar(
        elevation: 0,
        title: Text(this.widget.title ?? ''),
        leading: GestureDetector(
          onTap: onBack,
          child: Image.asset('images/icon_arrow_back_black.png'),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: onShare,
            child: Image.asset('images/icon_menu_share.png'),
          ),
        ],
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  onBack() {
    Navigator.pop(context);
  }

  onShare() {
    Share.share(this.widget.url);
  }
}