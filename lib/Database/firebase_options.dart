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
    apiKey: 'AIzaSyDArCwGrIFwibXx3oCGDcvNvmoWNQXqjZA',
    appId: '1:987663840328:web:6e377027c6d6a0a721d47d',
    messagingSenderId: '987663840328',
    projectId: 'dashboard-413e7',
    authDomain: 'dashboard-413e7.firebaseapp.com',
    storageBucket: 'dashboard-413e7.appspot.com',
    measurementId: 'G-N71FH4WP8Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaOabTqx38LY4Fpibf85ygCxnEpYry4l0',
    appId: '1:987663840328:android:53417c5a06aab67f21d47d',
    messagingSenderId: '987663840328',
    projectId: 'dashboard-413e7',
    storageBucket: 'dashboard-413e7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHwdGZ-EU1pgmosbEb2d_cST1Xw2mZXeI',
    appId: '1:987663840328:ios:025c09871f579b8e21d47d',
    messagingSenderId: '987663840328',
    projectId: 'dashboard-413e7',
    storageBucket: 'dashboard-413e7.appspot.com',
    iosClientId: '987663840328-rujuh9836skg17sl4pkb4snuuthm0t53.apps.googleusercontent.com',
    iosBundleId: 'com.example.dashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHwdGZ-EU1pgmosbEb2d_cST1Xw2mZXeI',
    appId: '1:987663840328:ios:74121e0ba89e9aaa21d47d',
    messagingSenderId: '987663840328',
    projectId: 'dashboard-413e7',
    storageBucket: 'dashboard-413e7.appspot.com',
    iosClientId: '987663840328-9hh2nc7jk8o4obcos0uj3mvrl44benie.apps.googleusercontent.com',
    iosBundleId: 'com.example.dashboard.RunnerTests',
  );
}
