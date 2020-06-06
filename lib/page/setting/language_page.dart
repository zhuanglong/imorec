import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:imorec/provider/locale_provider.dart';
import 'package:imorec/provider/theme_provider.dart';
import 'package:imorec/common/i18n/Language_names.dart';
import 'package:imorec/util/navigator_util.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  List list = [
    {'locale': LanguageNames.system, 'asName': '跟随系统'},
    {'locale': LanguageNames.zh_CN, 'asName': '中文'},
    {'locale': LanguageNames.en_US, 'asName': 'English'},
  ];

  void onBack() {
    NavigatorUtil.back(context);
  }

  void onChangeLanguage(String locale) {
    context.read<LocaleProvider>().setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '切换语言',
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
    LocaleProvider localeProvider = Provider.of<LocaleProvider>(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChangeLanguage(item['locale']),
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
                opacity: localeProvider.locale == item['locale'] ? 1 : 0,
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