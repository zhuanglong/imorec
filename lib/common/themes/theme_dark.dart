import 'dart:ui';
import 'package:flutter/material.dart';

const Color defaultTextColor = Color(0xFFB8B8B8);

Map themeDark = {
  'primaryColor': Color(0xFF3F7AE0),
  'backgroundColor': Color(0xFF303233),

  // NavigationBar
  'navStatusBarStyle': Brightness.dark,
  'navBackgroundColor': Color(0xFF303233),
  'navIconColor': Color(0xffffffff),
  'navTitleColor': Color(0xffffffff),

  // SectionBar
  'sectionBarLineColor': Colors.blue,

  // 底部栏
  'bottomNavBackgroundColor': Color(0xFF303233),
  'bottomNavTextActiveColor': Color(0xFF0071ce),

  // Text
  'textColor1': Color(0xFFB8B8B8),

  // Item
  'itemSeparatorColor': Color(0xFF222222),

  // Icon
  'icon': {
    'arrow_back': 'assets/images/icon_arrow_back_white.png',
    'menu_share': 'assets/images/icon_menu_share_white.png',
    'tab_home': 'assets/images/tab_home.png',
    'tab_home_selected': 'assets/images/tab_home_selected_blue.png',
    'tab_my': 'assets/images/tab_my.png',
    'tab_my_selected': 'assets/images/tab_my_selected_blue.png',
  },
};