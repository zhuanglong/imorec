import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
class DeviceUtil {
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


// static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
// static bool get isMobile => isAndroid || isIOS;
// static bool get isWeb => kIsWeb;

// static bool get isWindows => Platform.isWindows;
// static bool get isMacOS => Platform.isMacOS;
// static bool get isLinux => Platform.isLinux;
// static bool get isFuchsia => Platform.isFuchsia;
// static bool get isAndroid => Platform.isAndroid;
// static bool get isIOS => Platform.isIOS;