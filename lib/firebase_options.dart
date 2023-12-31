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
    apiKey: 'AIzaSyAk7axwNm4S2DOvbC53k1tYEWqztOxpSGQ',
    appId: '1:581296192560:web:5b3383931d6ec903a241f5',
    messagingSenderId: '581296192560',
    projectId: 'soft-dev-project-23172',
    authDomain: 'soft-dev-project-23172.firebaseapp.com',
    storageBucket: 'soft-dev-project-23172.appspot.com',
    measurementId: 'G-4NPCPECPEQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJZ0gqrIaiX9BhBJvJM5GtaUPExcRxhNQ',
    appId: '1:581296192560:android:8d66a3c789d420a9a241f5',
    messagingSenderId: '581296192560',
    projectId: 'soft-dev-project-23172',
    storageBucket: 'soft-dev-project-23172.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtJCqQd5g1fqwcSQ7SxUDm1OPKwVoqCUg',
    appId: '1:581296192560:ios:aacd7475c61e0d0ea241f5',
    messagingSenderId: '581296192560',
    projectId: 'soft-dev-project-23172',
    storageBucket: 'soft-dev-project-23172.appspot.com',
    iosBundleId: 'com.example.softDevApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDtJCqQd5g1fqwcSQ7SxUDm1OPKwVoqCUg',
    appId: '1:581296192560:ios:5c9c8a794985e79ba241f5',
    messagingSenderId: '581296192560',
    projectId: 'soft-dev-project-23172',
    storageBucket: 'soft-dev-project-23172.appspot.com',
    iosBundleId: 'com.example.softDevApp.RunnerTests',
  );
}
