import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:imorec/page/home/home_page.dart';
import 'package:imorec/page/my/my_page.dart';
import 'package:imorec/common/constant.dart';
import 'package:imorec/common/style/app_style.dart';
import 'package:imorec/common/event/event_bus.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int tabIndex = 0;

  List<Image> tabImages = [
    Image.asset('images/tab_home.png'),
    Image.asset('images/tab_my.png'),
  ];

  List<Image> tabSelectedImages = [
    Image.asset('images/tab_home_selected.png'),
    Image.asset('images/tab_my_selected.png'),
  ];

  @override
  void initState() {
    super.initState();
    eventBus.on(EventToggleTabBarIndex, (arg) {
      setState(() {
        tabIndex = arg;
      });
    });
  }

  @override
  void dispose() {
    eventBus.off(EventToggleTabBarIndex);
    super.dispose();
  }

  Image getTabIcon(int index) {
    if (index == tabIndex) {
      return tabSelectedImages[index];
    } else {
      return tabImages[index];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMoRec',
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        dividerColor: Color(0xFFEEEEEE),
        scaffoldBackgroundColor: AppColor.paper,
        textTheme: TextTheme(
          body1: TextStyle(color: AppColor.darkGrey),
        ),
      ),
      home: buildRoot(),
    );
  }

  Widget buildRoot() {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          HomePage(),
          MyPage(),
        ],
        index: tabIndex,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: AppColor.primary,
        border: Border(top: BorderSide.none),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: getTabIcon(0),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: getTabIcon(1),
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
  }
}