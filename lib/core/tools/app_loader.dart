import 'package:background_fetch/background_fetch.dart';
import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/core/network/remote_env.dart';
import 'package:dirumahaja/core/tools/location_updater.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AppLoader {
  Future<void> onAppStart({bool isDebug = false}) async {
    // setup remote enve
    RemoteEnv.setInstance(RemoteEnv.PRODUCTION);

    // set API
    Api(secret: RemoteEnv.get().secret);

    // kill currently ongoing task, becaus opening the app will do check in
    BackgroundFetch.stop().then((int status) {
      // print('[BackgroundFetch] stop success: $status');
    });
    // Register to receive BackgroundFetch events after app is terminated.
    // Requires {stopOnTerminate: false, enableHeadless: true}
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

    // Set `enableInDevMode` to true to see reports while in debug mode
    // This is only to be used for confirming that reports are being
    // submitted as expected. It is not intended to be used for everyday
    // development.
    // Crashlytics.instance.enableInDevMode = true;

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.setAutoInitEnabled(true);
  }

  /// This "Headless Task" is run when app is terminated.
  void backgroundFetchHeadlessTask(String taskId) async {
    // location update process
    LocationUpdater.doCheckIn(source: 'headless');

    BackgroundFetch.finish(taskId);
  }

  // instance
  static AppLoader _instance = AppLoader();
  static AppLoader get() => _instance;
}
