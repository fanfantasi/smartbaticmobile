import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: '',
        appId: '',
        messagingSenderId: '',
        projectId: '',
        authDomain: '',
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: '',
        appId: '',
        messagingSenderId: '',
        projectId: '',
        authDomain: '',
        iosBundleId: '',
        databaseURL: '',
        iosClientId: '',
        androidClientId: '',
        storageBucket: '',
      );
    } else {
      // Android
      return const FirebaseOptions(
        apiKey: 'AIzaSyBZDkrATGqMb8z5HsiQ6SQrEFsKAHFbGsA',
        appId: '1:822381416388:android:699d80abfb553c09ab5e91',
        messagingSenderId: '822381416388',
        projectId: 'smart-baik-class',
        authDomain: 'smart-baik-class.firebaseapp.com',
        databaseURL: 'https://smart-baik-class.firebaseio.com',
        androidClientId:
            '822381416388-0vh4ap6t0ff1n4mjso2870rbkoksm2re.apps.googleusercontent.com',
      );
    }
  }
}
