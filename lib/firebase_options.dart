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
    apiKey: 'AIzaSyB9p5G5d9I1l-HSkjpfV3hNso0RO9EWkTE',
    appId: '1:364398081041:web:dd9028a4bab5d4d80dadb0',
    messagingSenderId: '364398081041',
    projectId: 'noter-ca043',
    authDomain: 'noter-ca043.firebaseapp.com',
    storageBucket: 'noter-ca043.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtHCLauNAAij0aBtb08VveDxoQN6a_u1g',
    appId: '1:364398081041:android:fdbc665b104b05530dadb0',
    messagingSenderId: '364398081041',
    projectId: 'noter-ca043',
    storageBucket: 'noter-ca043.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeIaGYfhGD5cOydreP_b-3jpk-H8A-0HU',
    appId: '1:364398081041:ios:2a28e6bbfbaa84750dadb0',
    messagingSenderId: '364398081041',
    projectId: 'noter-ca043',
    storageBucket: 'noter-ca043.appspot.com',
    iosBundleId: 'com.example.noter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeIaGYfhGD5cOydreP_b-3jpk-H8A-0HU',
    appId: '1:364398081041:ios:e701d0f144ddb57a0dadb0',
    messagingSenderId: '364398081041',
    projectId: 'noter-ca043',
    storageBucket: 'noter-ca043.appspot.com',
    iosBundleId: 'com.example.noter.RunnerTests',
  );
}