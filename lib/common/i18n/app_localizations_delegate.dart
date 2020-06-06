import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:imorec/common/i18n/app_localizations.dart';

// 多语言代理
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  AppLocalizationsDelegate();

  // 支持的语言
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('en', 'US'),
      Locale('zh', 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) {
    // 支持中文和英文
    return true; // 同等 ['en', 'zh'].contains(locale.languageCode) 
  }

  // 根据 locale，创建一个对象提供当前 locale 下的文本显示
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }

  // 全局静态的代理
  static AppLocalizationsDelegate delegate = AppLocalizationsDelegate();
}