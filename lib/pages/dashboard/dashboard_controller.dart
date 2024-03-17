import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;
  var timer = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  Future<bool> onWillPop() async {
    if (tabIndex != 0) {
      changeTabIndex(0);
      timer = 0;
    } else {
      timer = timer + 1;
      if (timer < 2) {
        Fluttertoast.showToast(
            msg: "Tap again to exit",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue.withOpacity(.4),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        return true;
      }
    }
    // ignore: null_check_always_fails
    return null!;
  }
}
