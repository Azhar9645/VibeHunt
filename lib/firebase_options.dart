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
    apiKey: 'AIzaSyDDxa1Fre__l1qRlAZqfEG6DWX4B5HaHcI',
    appId: '1:821041319012:web:c66aa7b9510cc4c290a371',
    messagingSenderId: '821041319012',
    projectId: 'vibehunt-47f67',
    authDomain: 'vibehunt-47f67.firebaseapp.com',
    storageBucket: 'vibehunt-47f67.appspot.com',
    measurementId: 'G-N8S4PQCE27',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCjtB8psr4nOkSPzduKtmVfAl8qB_vYdM',
    appId: '1:821041319012:android:5de840adb8c56ac190a371',
    messagingSenderId: '821041319012',
    projectId: 'vibehunt-47f67',
    storageBucket: 'vibehunt-47f67.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDK-Fnd52kRV1S7uuo5eNggko0at-DyzyM',
    appId: '1:821041319012:ios:0c18393c77e7250590a371',
    messagingSenderId: '821041319012',
    projectId: 'vibehunt-47f67',
    storageBucket: 'vibehunt-47f67.appspot.com',
    iosBundleId: 'com.example.vibehunt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDK-Fnd52kRV1S7uuo5eNggko0at-DyzyM',
    appId: '1:821041319012:ios:0c18393c77e7250590a371',
    messagingSenderId: '821041319012',
    projectId: 'vibehunt-47f67',
    storageBucket: 'vibehunt-47f67.appspot.com',
    iosBundleId: 'com.example.vibehunt',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDDxa1Fre__l1qRlAZqfEG6DWX4B5HaHcI',
    appId: '1:821041319012:web:e20a3957128f2c6290a371',
    messagingSenderId: '821041319012',
    projectId: 'vibehunt-47f67',
    authDomain: 'vibehunt-47f67.firebaseapp.com',
    storageBucket: 'vibehunt-47f67.appspot.com',
    measurementId: 'G-YDF9BWGSWF',
  );

}