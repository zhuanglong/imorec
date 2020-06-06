import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:imorec/provider/theme_provider.dart';
import 'package:imorec/common/themes/theme_names.dart';
import 'package:imorec/util/navigator_util.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  List list = [
    {'name': ThemeNames.system, 'asName': '跟随系统'},
    {'name': ThemeNames.dark, 'asName': '夜间模式'},
    {'name': ThemeNames.light, 'asName': '简洁白'},
  ];

  void onBack() {
    NavigatorUtil.back(context);
  }

  void onChangeTheme(String themeName) {
    context.read<ThemeProvider>().setTheme(themeName);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '主题颜色',
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
          children: list.map<Widget>((item) => buildItem(item)).toList(),
        ),
      ),
    );
  }

  Widget buildItem(Map item) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChangeTheme(item['name']),
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
                    item['asName'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Opacity(
                opacity: ThemeProvider.getThemeForLocalStorage() == item['name'] ? 1 : 0,
                child: Icon(
                  Icons.done,
                  color: Color(0xFF0071ce),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}