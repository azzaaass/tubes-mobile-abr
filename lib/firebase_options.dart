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
    apiKey: 'AIzaSyCuqg4NbYX-QNhmOzW90b3MW-39i2087kI',
    appId: '1:829435033592:web:ddcc944aacff4c2226080d',
    messagingSenderId: '829435033592',
    projectId: 'idlix-31849',
    authDomain: 'idlix-31849.firebaseapp.com',
    storageBucket: 'idlix-31849.appspot.com',
    measurementId: 'G-ZF9R8S68WE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzao4EtsDMUA7h3lotbOqUyNgnme29IbE',
    appId: '1:829435033592:android:0378d910ec0ebeae26080d',
    messagingSenderId: '829435033592',
    projectId: 'idlix-31849',
    storageBucket: 'idlix-31849.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCiArwl_a_tHZzdMOzBX2WSlzaHQVRMKJI',
    appId: '1:829435033592:ios:cf5550110a871f4c26080d',
    messagingSenderId: '829435033592',
    projectId: 'idlix-31849',
    storageBucket: 'idlix-31849.appspot.com',
    iosBundleId: 'com.example.idlix',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCiArwl_a_tHZzdMOzBX2WSlzaHQVRMKJI',
    appId: '1:829435033592:ios:506a0c58e1579c7e26080d',
    messagingSenderId: '829435033592',
    projectId: 'idlix-31849',
    storageBucket: 'idlix-31849.appspot.com',
    iosBundleId: 'com.example.idlix.RunnerTests',
  );
}
