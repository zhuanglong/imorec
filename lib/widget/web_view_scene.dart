import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:share/share.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:imorec/util/screen.dart';

class WebViewScene extends StatefulWidget {
  final String url;
  final String title;

  WebViewScene({@required this.url, this.title});

  _WebViewSceneState createState() => _WebViewSceneState();
}

class _WebViewSceneState extends State<WebViewScene> {
  @override
  void dispose() {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
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
          onTap: _onBack,
          child: Image.asset('images/icon_arrow_back_black.png'),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: _onShare,
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

  _onBack() {
    Navigator.pop(context);
  }

  _onShare() {
    Share.share(this.widget.url);
  }
}