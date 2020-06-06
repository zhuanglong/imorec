import 'dart:ui';
import 'package:flutter/material.dart';

const Color defaultTextColor = Color(0xFF333333);

Map themeLight = {
  'primaryColor': Color(0xFF4688FA),
  'backgroundColor': Color(0xffffffff),

  // NavigationBar
  'navStatusBarStyle': Brightness.light,
  'navBackgroundColor': Color(0xffffffff),
  'navIconColor': Color(0xFF303233),
  'navTitleColor': Color(0xFF303233),

  // SectionBar
  'sectionBarLineColor': Color(0xFF333333),

  // 底部栏
  'bottomNavBackgroundColor': Color(0xffffffff),
  'bottomNavTextActiveColor': Color(0xFF5C5C5C),

  // Text
  'textColor1': Color(0xFF333333),

  // Item
  'itemSeparatorColor': Color(0xFFDDDDDD),

  // Icon
  'icon': {
    'arrow_back': 'assets/images/icon_arrow_back_black.png',
    'menu_share': 'assets/images/icon_menu_share_black.png',
    'tab_home': 'assets/images/tab_home.png',
    'tab_home_selected': 'assets/images/tab_home_selected.png',
    'tab_my': 'assets/images/tab_my.png',
    'tab_my_selected': 'assets/images/tab_my_selected.png',
  },
};