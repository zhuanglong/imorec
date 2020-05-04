import 'package:flutter/material.dart';
import 'package:imorec/app/app_color.dart';
import 'package:imorec/app/root_scene.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppScene extends StatelessWidget {
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
      home: RootScene(),
    );
  }
}