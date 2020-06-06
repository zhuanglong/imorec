import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static show(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static showDarkGrey(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Color(0xFF333333),
      textColor: Colors.white,
    );
  }
}