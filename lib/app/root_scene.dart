import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:imorec/home/home_scene.dart';
import 'package:imorec/my/my_scene.dart';

import 'package:imorec/app/constant.dart';
import 'package:imorec/app/app_color.dart';

import 'package:imorec/util/event_bus.dart';

class RootScene extends StatefulWidget {
  final Widget child;

  RootScene({Key key, this.child}) : super(key: key);

  @override
  _RootSceneState createState() => _RootSceneState();
}

class _RootSceneState extends State<RootScene> {
  int _tabIndex = 0;

  List<Image> _tabImages = [
    Image.asset('images/tab_home.png'),
    Image.asset('images/tab_my.png'),
  ];

  List<Image> _tabSelectedImages = [
    Image.asset('images/tab_home_selected.png'),
    Image.asset('images/tab_my_selected.png'),
  ];

  @override
  void initState() {
    super.initState();
    eventBus.on(EventToggleTabBarIndex, (arg) {
      setState(() {
        _tabIndex = arg;
      });
    });
  }

  @override
  void dispose() {
    eventBus.off(EventToggleTabBarIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          HomeScene(),
          MyScene(),
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: AppColor.primary,
        border: Border(top: BorderSide.none),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _getTabIcon(0),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: _getTabIcon(1),
            title: Text('我的'),
          ),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }

  Image _getTabIcon(int index) {
    if (index == _tabIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabImages[index];
    }
  }
}