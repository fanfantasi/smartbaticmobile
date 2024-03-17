import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFbc9645);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kPrimaryBgColor = Color(0XFFf8faf9);

class AppString {
  static const String baseurl = 'https://smartapi.smartbatikclass.com/';
  static const String nameapps = 'Smart Batik Class';

  static String topic(int string) {
    switch (string) {
      case 0:
        return 'Belum Mulai';

      case 1:
        return 'Mulai';

      default:
        return 'Selesai';
    }
  }
}
