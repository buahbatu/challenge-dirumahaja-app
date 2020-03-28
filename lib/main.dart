import 'dart:async';
import 'package:dirumahaja/feature/splash/splash_screen.dart';
import 'package:dirumahaja/core/tools/app_loader.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

bool isDebug = false;

void main() {
  runZoned<Future<void>>(() async {
    // run on splash screen
    await AppLoader.get().onAppStart(isDebug: isDebug);

    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge #dirumahaja',
      home: SplashScreen(title: '#dirumahaja \nChallenge'),
    );
  }
}
