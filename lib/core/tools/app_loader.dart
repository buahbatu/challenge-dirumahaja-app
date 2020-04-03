import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/core/network/remote_env.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AppLoader {
  Future<void> onAppStart({bool isDebug = false}) async {
    // setup remote enve
    RemoteEnv.setInstance(RemoteEnv.PRODUCTION);

    // set API
    Api(secret: RemoteEnv.get().secret);

    // Set `enableInDevMode` to true to see reports while in debug mode
    // This is only to be used for confirming that reports are being
    // submitted as expected. It is not intended to be used for everyday
    // development.
    // Crashlytics.instance.enableInDevMode = true;

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
  }

  // instance
  static AppLoader _instance = AppLoader();
  static AppLoader get() => _instance;
}
