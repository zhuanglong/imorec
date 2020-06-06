import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';

import 'package:imorec/common/constant.dart';

class LocaleProvider extends ChangeNotifier {
  String _locale;
  String get locale => _locale;

  LocaleProvider([this._locale]);

  static String getLocaleForLocalStorage() {
    /// 设置默认值 null？
    /// 因为切换语言跟随系统的值是 null，SpUtil.putString 存 null，
    /// 但 SpUtil.getString 取出来时并不是 null，而是什么都没有。
    return SpUtil.getString(Constant.key_locale, defValue: null);
  }

  static setLocaleForLocalStorage(String locale) {
    SpUtil.putString(Constant.key_locale, locale);
  }

  Locale getLocale() {
    if (_locale == null) return null;
    var t = _locale.split('_');
    return Locale(t[0], t[1]);
  }

  // 设置语言
  void setLocale(String locale) {
    if (_locale == locale) return;
    _locale = locale;
    LocaleProvider.setLocaleForLocalStorage(_locale);
    notifyListeners();
  }

  // 同步语言
  void syncLocale() {
    setLocale(LocaleProvider.getLocaleForLocalStorage());
  }
}