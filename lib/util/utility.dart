import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';

fixedFontSize(double fontSize) {
  return fontSize / MediaQueryData.fromWindow(ui.window).textScaleFactor;
}