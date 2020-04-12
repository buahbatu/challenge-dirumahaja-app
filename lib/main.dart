import 'dart:async';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/feature/splash/splash_screen.dart';
import 'package:dirumahaja/core/tools/app_loader.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

bool isDebug = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned<Future<void>>(() async {
    // run on splash screen
    await AppLoader.get().onAppStart(isDebug: isDebug);

    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge #dirumahaja',
      theme: ThemeData(accentColor: AppColor.titleColor.toHexColor()),
      home: SplashScreen(),
    );
  }
}
