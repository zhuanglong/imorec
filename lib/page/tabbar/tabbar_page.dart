import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:imorec/page/home/home_page.dart';
import 'package:imorec/page/my/my_page.dart';
import 'package:imorec/common/constant.dart';
import 'package:imorec/common/event/event_bus.dart';
import 'package:imorec/provider/theme_provider.dart';

class TabbarPage extends StatefulWidget {
  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    eventBus.on(Constant.EventToggleTabBarIndex, (arg) {
      setState(() {
        tabIndex = arg;
      });
    });
  }

  @override
  void dispose() {
    eventBus.off(Constant.EventToggleTabBarIndex);
    super.dispose();
  }

  Image getTabIcon(ThemeProvider themeProvider, int index) {
    if (index == tabIndex) {
      return [
        Image.asset(themeProvider.theme['icon']['tab_home_selected']),
        Image.asset(themeProvider.theme['icon']['tab_my_selected']),
      ][index];
    } else {
      return [
        Image.asset(themeProvider.theme['icon']['tab_home']),
        Image.asset(themeProvider.theme['icon']['tab_my']),
      ][index];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) {
        return Scaffold(
          body: IndexedStack(
            children: <Widget>[
              HomePage(),
              MyPage(),
            ],
            index: tabIndex,
          ),
          bottomNavigationBar: CupertinoTabBar(
            backgroundColor: themeProvider.theme['bottomNavBackgroundColor'],
            activeColor: themeProvider.theme['bottomNavTextActiveColor'],
            border: Border(top: BorderSide.none),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: getTabIcon(themeProvider, 0),
                title: Text('首页'),
              ),
              BottomNavigationBarItem(
                icon: getTabIcon(themeProvider, 1),
                title: Text('我的'),
              ),
            ],
            currentIndex: tabIndex,
            onTap: (index) {
              setState(() {
                tabIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}