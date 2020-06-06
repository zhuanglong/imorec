import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:imorec/util/device_util.dart';
import 'package:imorec/provider/theme_provider.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  final String title;

  WebViewWidget({@required this.url, this.title});

  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  void dispose() {
    DeviceUtil.updateStatusBarStyle('light');
    super.dispose();
  }

  void onBack() {
    Navigator.pop(context);
  }

  void onShare() {
    Share.share(this.widget.url);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.select((ThemeProvider themeProvider) => themeProvider);
    return WebviewScaffold(
      url: this.widget.url,
      appBar: AppBar(
        title: Text(
          this.widget.title ?? '',
          style: TextStyle(
            color: themeProvider.theme['navTitleColor'],
          ),
        ),
        leading: GestureDetector(
          onTap: onBack,
          child: Image.asset(themeProvider.theme['icon']['arrow_back']),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: onShare,
            child: Image.asset(themeProvider.theme['icon']['menu_share']),
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
}