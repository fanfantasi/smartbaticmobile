import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/models/gallery.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EksperimenController extends GetxController {
  RxBool proccess = false.obs;
  RxBool empty = false.obs;
  RxBool submit = false.obs;
  late ApiService apiService = ApiService();
  late List<ResultGallery> resultgallery = [];
  final descController = TextEditingController();

  Future<void> fetchGallery({String? uid, String? materiid}) async {
    try {
      proccess.value = true;
      var res = await apiService.fetchEksperimen(uid: uid, materiid: materiid);
      resultgallery = res.result;
      if (res.result.isEmpty) {
        empty.value = true;
      } else {
        empty.value = false;
      }
      proccess.value = false;
    } catch (e) {
      proccess.value = false;
    }
  }

  Future<void> submitGallery({uid, photo, sekolahid, materiid}) async {
    try {
      submit.value = true;
      var res = await apiService.addEksperimen(
          uid: uid,
          desc: descController.text,
          photo: photo.path,
          sekolahid: sekolahid,
          materiid: materiid);
      if (!res.status) {
        Get.snackbar(
            'error', 'Upload Hasil Membatil gagal dilakukan, silahkan ulangi',
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
