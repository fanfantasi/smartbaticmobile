import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilController extends GetxController {
  late ApiService apiService = ApiService();

  RxString photo = ''.obs;
  RxBool emptyphoto = false.obs;
  RxBool submit = false.obs;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final nisController = TextEditingController();
  final jenjangController = TextEditingController();
  final sekolahController = TextEditingController();
  final jurusanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    var res = await apiService.checkLogin(uid: firebaseUser.uid);
    if (res.status) {
      emailController.text = res.result[0].email;
      nameController.text = res.result[0].displayname;
      nisController.text = res.result[0].userid;
      jenjangController.text = res.result[0].jenjang;
      sekolahController.text = res.result[0].sekolahid.toString();
      jurusanController.text = res.result[0].jurusan;
      photo.value = res.result[0].avatar;
      emptyphoto.value = false;
    }
  }

  Future<void> submitProfil({uid, avatar, photourl}) async {
    try {
      submit.value = true;
      var res = await apiService.updateprofile(
          uid: uid,
          displayname: nameController.text,
          userid: nisController.text,
          jurusan: jurusanController.text,
          avatar: (avatar == null) ? null : avatar.path);
      if (!res.status) {
        Get.snackbar('error', 'Update Profil gagal dilakukan, silahkan ulangi',
            colorText: Colors.black54,
            backgroundColor: kPrimaryColor.withOpacity(0.3),
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Informasi',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      }
      submit.value = false;
      Get.back(result: res.status);
    } catch (e) {
      Get.snackbar('error', 'Gagal terhubung ke server, Periksa Internet Anda',
          colorText: Colors.black54,
          backgroundColor: kPrimaryColor.withOpacity(0.3),
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          titleText: const Text(
            'Informasi',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ));
      submit.value = false;
    }
  }
}
