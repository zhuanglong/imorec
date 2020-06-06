import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:flustars/flustars.dart';

import 'package:imorec/common/constant.dart';
import 'package:imorec/common/themes/theme_dark.dart';
import 'package:imorec/common/themes/theme_light.dart';
import 'package:imorec/common/themes/theme_names.dart';

class ThemeProvider extends ChangeNotifier {
  Map _theme;
  Map get theme => _theme;

  static bool isDark(BuildContext context) {
    /// Theme.of(context).brightness 与 MediaQueryData.fromWindow(ui.window).platformBrightnes 的区别？
    /// 前者是 ThemeData 的 brightness 属性，是自定义的；
    /// 后者是获取系统的。
    return Theme.of(context).brightness == Brightness.dark;
  }

  static String getThemeForLocalStorage() {
    return SpUtil.getString(Constant.key_theme, defValue: ThemeNames.system);
  }

  static setThemeForLocalStorage(String themeName) {
    SpUtil.putString(Constant.key_theme, themeName);
  }

  // 设置主题
  void setTheme(String themeName) {
    switch (themeName) {
      case ThemeNames.dark:
        ThemeProvider.setThemeForLocalStorage(themeName);
        _theme = themeDark;
        break;
      case ThemeNames.light:
        ThemeProvider.setThemeForLocalStorage(themeName);
        _theme = themeLight;
        break;
      default:
        ThemeProvider.setThemeForLocalStorage(themeName);
        if (MediaQueryData.fromWindow(ui.window).platformBrightness == Brightness.dark) {
          _theme = themeDark;
        } else {
          _theme = themeLight;
        }
    }
    notifyListeners();
  }

  // 同步主题
  void syncTheme() {
    String themeName = ThemeProvider.getThemeForLocalStorage();
    setTheme(themeName);
  }

  // Flutter 自带控件的主题
  ThemeData getThemeData() {
    return ThemeData(
      // 设置 brightness 属性，才能用 Theme.of(context) 获取
      brightness: theme['navStatusBarStyle'],
      // 主色
      primaryColor: theme['primaryColor'],
      // 次级色，决定大多次的 Widget 颜色，如进度条、开关等
      accentColor: theme['primaryColor'],
      // 页面背景色
      scaffoldBackgroundColor: theme['backgroundColor'],
      // 导航栏背景色
      appBarTheme: AppBarTheme(
        elevation: 0,
        brightness: theme['navStatusBarStyle'],
        color: theme['navBackgroundColor'],
        iconTheme: IconThemeData(
          color: theme['navIconColor'],
        ),
      ),
      // 字体主题
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: theme['textColor1'],
        ),
      ),
    );
  }
}