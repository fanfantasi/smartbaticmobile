import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class SplashscreenController extends GetxController {
  RxString version = ''.obs;
  RxString buildNumber = ''.obs;
  RxBool isSigningIn = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    _getVersion();
    startSplashScreen();
  }

  void _getVersion() async {
    final PackageInfo _info = await PackageInfo.fromPlatform();
    version.value = _info.version;
    buildNumber.value = _info.buildNumber;
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 1);

    return Timer(duration, () async {
      await sessionCheck();
    });
  }

  Future<void> sessionCheck() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) {
      Get.offAndToNamed("/signup");
    } else {
      Get.offAndToNamed("/home", arguments: firebaseUser);
    }
  }

  void privacypolice() async {
    await sessionCheck();
  }
}
