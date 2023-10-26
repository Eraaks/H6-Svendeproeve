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
    apiKey: 'AIzaSyBpTPNtwbiQfb6YGD1jBmWq23-Tsnxhc6w',
    appId: '1:930960686314:web:75a6b7dcbb88239d27eb93',
    messagingSenderId: '930960686314',
    projectId: 'h6-svendeproeve-klatreapp',
    authDomain: 'h6-svendeproeve-klatreapp.firebaseapp.com',
    databaseURL: 'https://h6-svendeproeve-klatreapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'h6-svendeproeve-klatreapp.appspot.com',
    measurementId: 'G-7HBGY1WD8V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0YIR85r0ikptzbndjwDdx1LilQFr4N7w',
    appId: '1:930960686314:android:99fce7e7df81ffce27eb93',
    messagingSenderId: '930960686314',
    projectId: 'h6-svendeproeve-klatreapp',
    databaseURL: 'https://h6-svendeproeve-klatreapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'h6-svendeproeve-klatreapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5NYzVLP1VkHTebVDSYuZNRtftHcT3_Us',
    appId: '1:930960686314:ios:f5af9bf301b8547227eb93',
    messagingSenderId: '930960686314',
    projectId: 'h6-svendeproeve-klatreapp',
    databaseURL: 'https://h6-svendeproeve-klatreapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'h6-svendeproeve-klatreapp.appspot.com',
    iosBundleId: 'com.example.svendeproeveKlatreapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5NYzVLP1VkHTebVDSYuZNRtftHcT3_Us',
    appId: '1:930960686314:ios:c70f9997aa7aad3f27eb93',
    messagingSenderId: '930960686314',
    projectId: 'h6-svendeproeve-klatreapp',
    databaseURL: 'https://h6-svendeproeve-klatreapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'h6-svendeproeve-klatreapp.appspot.com',
    iosBundleId: 'com.example.svendeproeveKlatreapp.RunnerTests',
  );
}
