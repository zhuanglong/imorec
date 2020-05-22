import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
class ScreenUtil {
  static Size size(BuildContext context) => MediaQuery.of(context).size;

  static double width(BuildContext context) => size(context).width;

  static double height(BuildContext context) => size(context).height;

  static double topSafeHeight(BuildContext context) => MediaQuery.of(context).padding.top;

  static double bottomSafeHeight(BuildContext context) => MediaQuery.of(context).padding.bottom;

  static double navigationBarHeight(BuildContext context) => topSafeHeight(context) + kToolbarHeight;

  static bool isLandscape(BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;
  
  static double scale(BuildContext context) => MediaQuery.of(context).devicePixelRatio;

  static double textScaleFactor(BuildContext context) => MediaQuery.of(context).textScaleFactor;

  static updateStatusBarStyle(String type) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle.light;
    if (type == 'dark') {
      style = SystemUiOverlayStyle.dark;
    }
    return SystemChrome.setSystemUIOverlayStyle(style);
  }
}