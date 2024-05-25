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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBxlKRpyj4N41Texyvm96mCaVEjPPL63Po',
    appId: '1:621278659042:web:0dc7b5315328bfe69df9bb',
    messagingSenderId: '621278659042',
    projectId: 'document-orders',
    authDomain: 'document-orders.firebaseapp.com',
    storageBucket: 'document-orders.appspot.com',
    measurementId: 'G-GJ83V7D04P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGCle-kLEq81WIg57t1KXT7MO8F4NrHMs',
    appId: '1:621278659042:android:1004d3dc38b371d19df9bb',
    messagingSenderId: '621278659042',
    projectId: 'document-orders',
    storageBucket: 'document-orders.appspot.com',
  ); static const FirebaseOptions windows = FirebaseOptions(
   apiKey: "AIzaSyBxlKRpyj4N41Texyvm96mCaVEjPPL63Po",
  authDomain: "document-orders.firebaseapp.com",
  projectId: "document-orders",
  storageBucket: "document-orders.appspot.com",
  messagingSenderId: "621278659042",
  appId: "1:621278659042:web:f367e7500c73a3f09df9bb",
  measurementId: "G-043YE52BRM"
  );
}
 