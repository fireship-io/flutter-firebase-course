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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCCNqoW8gtIn2DYeqlC-dWP8SmiOvRD8Y',
    appId: '1:758773997881:android:743b0bba6de867fcd1c8e8',
    messagingSenderId: '758773997881',
    projectId: 'fireship-lessons',
    databaseURL: 'https://fireship-lessons.firebaseio.com',
    storageBucket: 'fireship-lessons.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHpFJY54w_YiXjCOfbVbsefn91FFUJ9PE',
    appId: '1:758773997881:ios:82656735bc074188d1c8e8',
    messagingSenderId: '758773997881',
    projectId: 'fireship-lessons',
    databaseURL: 'https://fireship-lessons.firebaseio.com',
    storageBucket: 'fireship-lessons.appspot.com',
    androidClientId:
        '758773997881-b4g2gerk1isv5ehq4h9s63hgnn433rjc.apps.googleusercontent.com',
    iosClientId:
        '758773997881-sk4tfalbk1oqh5f2vv4gbcjqdlm7lq5f.apps.googleusercontent.com',
    iosBundleId: 'io.fireship.quizapp',
  );
}
