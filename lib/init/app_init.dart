import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';

import 'package:provider/provider.dart';

import 'package:imorec/provider/locale_provider.dart';
import 'package:imorec/provider/theme_provider.dart';
import 'package:imorec/init/my_app.dart';

// 应用初始化
class AppInit {
  static void run() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化 SpUtil
    await SpUtil.getInstance();

    runApp(
      // 把 Provider 绑定在最外层
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider.value(value: LocaleProvider(LocaleProvider.getLocaleForLocalStorage())),
        ],
        child: MyApp(),
      ),
    );
  }
}