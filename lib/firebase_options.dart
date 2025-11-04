import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
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
    apiKey: 'AIzaSyBTmEe4ChPsoyQjgm43xkgFAi98KfSLEeY',
    appId: '1:358572740388:web:da68716ad5bb30846cadb1',
    messagingSenderId: '358572740388',
    projectId: 'altaone-10906',
    authDomain: 'altaone-10906.firebaseapp.com',
    storageBucket: 'altaone-10906.firebasestorage.app',
    measurementId: 'G-106T3WMT0K',
  );

//

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwkUIfcPmbXl3mnUMoxD4A3o3L0aGzZKE',
    appId: '1:358572740388:android:86943b43d4100bb66cadb1',
    messagingSenderId: '358572740388',
    projectId: 'altaone-10906',
    storageBucket: 'altaone-10906.firebasestorage.app',
  );

//

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOVue--wCUSdPAY_p0k5kk2NmhDV40IHg',
    appId: '1:358572740388:ios:c4a6bcad0d803a1c6cadb1',
    messagingSenderId: '358572740388',
    projectId: 'altaone-10906',
    storageBucket: 'altaone-10906.firebasestorage.app',
    androidClientId:
        '358572740388-ug74qmg3emm5p4f54a7ffcd50r5p3p6t.apps.googleusercontent.com',
    iosBundleId: 'com.quickdatesocial.android',
  );

//

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOVue--wCUSdPAY_p0k5kk2NmhDV40IHg',
    appId: '1:358572740388:ios:3f77d0b193ac9e8d6cadb1',
    messagingSenderId: '358572740388',
    projectId: 'altaone-10906',
    storageBucket: 'altaone-10906.firebasestorage.app',
    androidClientId:
        '358572740388-ug74qmg3emm5p4f54a7ffcd50r5p3p6t.apps.googleusercontent.com',
    iosBundleId: 'com.quickdatesocial.android',
  );

//

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBTmEe4ChPsoyQjgm43xkgFAi98KfSLEeY',
    appId: '1:358572740388:web:aa7e3f9e0310e0a46cadb1',
    messagingSenderId: '358572740388',
    projectId: 'altaone-10906',
    authDomain: 'altaone-10906.firebaseapp.com',
    storageBucket: 'altaone-10906.firebasestorage.app',
    measurementId: 'G-H19LPXT39N',
  );
}
