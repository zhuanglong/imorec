import 'dart:ui' as ui show window;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

MediaQueryData mediaQuery() {
  return MediaQueryData.fromWindow(ui.window);
}

class Screen {
  static double get width {
    return mediaQuery().size.width;
  }

  static double get height {
    return mediaQuery().size.height;
  }

  static double get scale {
    return mediaQuery().devicePixelRatio;
  }

  static double get textScaleFactor {
    return mediaQuery().textScaleFactor;
  }

  static double get navigationBarHeight {
    return mediaQuery().padding.top + kToolbarHeight;
  }

  static double get topSafeHeight {
    return mediaQuery().padding.top;
  }

  static double get bottomSafeHeight {
    return mediaQuery().padding.bottom;
  }

  static updateStatusBarStyle(SystemUiOverlayStyle style) {
    return SystemChrome.setSystemUIOverlayStyle(style);
  }
}