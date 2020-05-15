import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:imorec/app/app_color.dart';

class Toast {
  static show(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static showDartGrey(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: AppColor.darkGrey,
      textColor: Colors.white,
    );
  }
}