import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';

import 'package:imorec/router/router.dart';
import 'package:imorec/provider/locale_provider.dart';
import 'package:imorec/provider/theme_provider.dart';
import 'package:imorec/common/themes/theme_names.dart';
import 'package:imorec/common/i18n/app_localizations_delegate.dart';
import 'package:imorec/page/home/splash_page.dart';
import 'package:imorec/util/toast.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness lastTimePlatformBrightness = MediaQueryData.fromWindow(ui.window).platformBrightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ThemeProvider>().syncTheme();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停
        break;
      case AppLifecycleState.resumed: // 从后台切换前台，界面可见
        // 监听是否在后台开启或关闭了暗黑模式，从而更新主题。
        if (ThemeProvider.getThemeForLocalStorage() != ThemeNames.system) return;
        if (lastTimePlatformBrightness == null) return;
        if (lastTimePlatformBrightness != MediaQueryData.fromWindow(ui.window).platformBrightness) {
          Toast.show('主题更新');
          context.read<ThemeProvider>().syncTheme();
        }
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        lastTimePlatformBrightness = MediaQueryData.fromWindow(ui.window).platformBrightness;
        break;
      case AppLifecycleState.detached: // APP 结束时调用
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, // 去除右上角的 Debug 标签
            navigatorObservers: [routeObserver],

            // 注册主题
            theme: themeProvider.getThemeData(),

            // 注册多语言代理
            localizationsDelegates: [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizationsDelegate.delegate,
            ], 
            // 支持的语言
            supportedLocales: AppLocalizationsDelegate.delegate.supportedLocales,
            // 应用内切换语言
            locale: localeProvider.getLocale(),

            home: SplashPage(),
            routes: Router.routes,
          );
        },
      );
  }
}