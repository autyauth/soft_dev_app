// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCoeel7eWtEY-HS9Gjs3w6woSUu53pUiY4',
    appId: '1:849281117501:web:46d73d97a30cf53d80a954',
    messagingSenderId: '849281117501',
    projectId: 'softdev01-30a84',
    authDomain: 'softdev01-30a84.firebaseapp.com',
    storageBucket: 'softdev01-30a84.appspot.com',
    measurementId: 'G-H0NZDFHJ6C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaEmJ7tNCvUCLqXIdEpppmypvOfikMkeE',
    appId: '1:849281117501:android:1222778f02aea27f80a954',
    messagingSenderId: '849281117501',
    projectId: 'softdev01-30a84',
    storageBucket: 'softdev01-30a84.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJGuohK-EZSc1u4EkVSTOg2-6KRzpaWjo',
    appId: '1:849281117501:ios:68f79e7d2fefcf2e80a954',
    messagingSenderId: '849281117501',
    projectId: 'softdev01-30a84',
    storageBucket: 'softdev01-30a84.appspot.com',
    iosBundleId: 'com.example.softDevApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJGuohK-EZSc1u4EkVSTOg2-6KRzpaWjo',
    appId: '1:849281117501:ios:f142d6b3a6e1690280a954',
    messagingSenderId: '849281117501',
    projectId: 'softdev01-30a84',
    storageBucket: 'softdev01-30a84.appspot.com',
    iosBundleId: 'com.example.softDevApp.RunnerTests',
  );
}
