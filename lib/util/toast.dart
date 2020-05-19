import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:imorec/common/style/app_style.dart';

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