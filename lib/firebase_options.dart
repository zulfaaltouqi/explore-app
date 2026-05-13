import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBAjmGurzAwyb9Xgf3sPMTW2bjyDir6jng',
    appId: '1:414070575641:web:61e0ac0091b13454ba1088',
    messagingSenderId: '414070575641',
    projectId: 'btech-9e071',
    authDomain: 'btech-9e071.firebaseapp.com',
    databaseURL: 'https://btech-9e071-default-rtdb.firebaseio.com',
    storageBucket: 'btech-9e071.firebasestorage.app',
    measurementId: 'G-TNLM796H75',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSOL-imQLkJkqe_5GRIyv05IW4Wn7K_lc',
    appId: '1:414070575641:android:e992f21eae631715ba1088',
    messagingSenderId: '414070575641',
    projectId: 'btech-9e071',
    databaseURL: 'https://btech-9e071-default-rtdb.firebaseio.com',
    storageBucket: 'btech-9e071.firebasestorage.app',
  );
}
