import 'package:flutter/material.dart';

import 'package:imorec/common/i18n/language_base.dart';
import 'package:imorec/common/i18n/language_en_US.dart';
import 'package:imorec/common/i18n/language_zh_CN.dart';

class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);

  // 根据 locale.languageCode 加载对应语言
  static Map<String, LanguageBase> _localizedValues = {
    'en': LanguageenUS(),
    'zh': LanguagezhCN(),
  };

  LanguageBase get currentLocalized {
    if (_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode];
    }
    return _localizedValues['en'];
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  static LanguageBase i18n(BuildContext context) {
    return (Localizations.of(context, AppLocalizations) as AppLocalizations).currentLocalized;
  }
}