import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:imorec/provider/theme_provider.dart';
import 'package:imorec/router/router.dart';
import 'package:imorec/util/device_util.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ThemeProvider themeProvider = ThemeProvider();

  void onBack() {
    Router.back(context);
  }

  @override
  void dispose() {
    DeviceUtil.updateStatusBarStyle('light');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// ` Consumer `
    /// 和 ` ThemeProvider themeProvider = context.select((ThemeProvider themeProvider) => themeProvider); `
    /// 效果是一样的。
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '设置',
              style: TextStyle(
                color: themeProvider.theme['navTitleColor'],
              ),
            ),
            leading: GestureDetector(
              onTap: onBack,
              child: Image.asset(themeProvider.theme['icon']['arrow_back']),
            ),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                buildItem('主题颜色', () => Router.pushThemePage(context)),
                buildItem('切换语言', () => Router.pushLanguagePage(context)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildItem(String text, onTap) {
    /// 这里直接用 themeProvider 不会更新，为什么呢？
    /// 当前只能从上级传递，或使用 select 解决。
    /// 有空再研究下这个问题。
    ThemeProvider themeProvider = context.select((ThemeProvider themeProvider) => themeProvider);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: themeProvider.theme['itemSeparatorColor'], width: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: themeProvider.theme['textColor1'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}