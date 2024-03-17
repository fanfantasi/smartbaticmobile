import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late ApiService apiService = ApiService();

  signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);
      if (googleUser != null) {
        var res = await apiService.addorupdate(
            uid: authResult.user?.uid,
            displayname: authResult.user?.displayName,
            email: authResult.user?.email,
            avatar: authResult.user?.photoURL);
        if (res.status) {
          Get.offAndToNamed("/home", arguments: authResult.user);
        } else {
          await _auth.signOut();
          Get.snackbar('info', 'Login Gagal, Silahkan Ulangi Lagi',
              colorText: Colors.black54,
              backgroundColor: kPrimaryColor.withOpacity(0.3),
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              titleText: const Text(
                'Informasi',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ));
        }
      }
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }
}
