// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyA61p-8DlQaPUiCBwvcE0Yaz7GloY1lowo',
    appId: '1:291690579387:web:4026b7215d60e036a3f09e',
    messagingSenderId: '291690579387',
    projectId: 'rollshop-583a3',
    authDomain: 'rollshop-583a3.firebaseapp.com',
    storageBucket: 'rollshop-583a3.firebasestorage.app',
    measurementId: 'G-NX1ED2L120',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVZ7YDKDL2YtieR9q-bzqplZ7tWYINiCU',
    appId: '1:291690579387:android:531f64ab02470625a3f09e',
    messagingSenderId: '291690579387',
    projectId: 'rollshop-583a3',
    storageBucket: 'rollshop-583a3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpsD_9Z0X0NMadph0he0AmM0Gq91KbeUc',
    appId: '1:291690579387:ios:40ef0d8fac4415daa3f09e',
    messagingSenderId: '291690579387',
    projectId: 'rollshop-583a3',
    storageBucket: 'rollshop-583a3.firebasestorage.app',
    iosBundleId: 'com.osman.rollshop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBpsD_9Z0X0NMadph0he0AmM0Gq91KbeUc',
    appId: '1:291690579387:ios:40ef0d8fac4415daa3f09e',
    messagingSenderId: '291690579387',
    projectId: 'rollshop-583a3',
    storageBucket: 'rollshop-583a3.firebasestorage.app',
    iosBundleId: 'com.osman.rollshop',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA61p-8DlQaPUiCBwvcE0Yaz7GloY1lowo',
    appId: '1:291690579387:web:3e047d9ef920467da3f09e',
    messagingSenderId: '291690579387',
    projectId: 'rollshop-583a3',
    authDomain: 'rollshop-583a3.firebaseapp.com',
    storageBucket: 'rollshop-583a3.firebasestorage.app',
    measurementId: 'G-3Z3C4RYYY7',
  );
}
