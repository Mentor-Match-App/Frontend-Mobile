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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDFOjkB2iyu-r0pf7bgjFRvHMntyHdvXo8',
    appId: '1:121006467880:web:edd8a51f2e7bdcde72fe1d',
    messagingSenderId: '121006467880',
    projectId: 'mentor-match-412713',
    authDomain: 'mentor-match-412713.firebaseapp.com',
    storageBucket: 'mentor-match-412713.appspot.com',
    measurementId: 'G-8NT8C5VNJE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAn4qbk_3Y_xPDfuvMJSVotdDwR2mQs2Jk',
    appId: '1:121006467880:android:b1be9914bf632d5e72fe1d',
    messagingSenderId: '121006467880',
    projectId: 'mentor-match-412713',
    storageBucket: 'mentor-match-412713.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkGfyUp3j7COlJJeaCJTeKdSoLsSicOyo',
    appId: '1:121006467880:ios:420706f8aa7dac4d72fe1d',
    messagingSenderId: '121006467880',
    projectId: 'mentor-match-412713',
    storageBucket: 'mentor-match-412713.appspot.com',
    androidClientId: '121006467880-h8c87puf5phhsem47thknqdasudpuc4s.apps.googleusercontent.com',
    iosClientId: '121006467880-f6ir9ufdr3if5k426hqhi2b4gr7d94tr.apps.googleusercontent.com',
    iosBundleId: 'com.example.mentormatchApps',
  );
}
