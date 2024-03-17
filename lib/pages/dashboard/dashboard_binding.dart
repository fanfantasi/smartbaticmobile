import 'package:chat_apps/pages/home/home_controller.dart';
import 'package:chat_apps/pages/materi/materi_controller.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MoreController>(() => MoreController());
    Get.lazyPut<MateriController>(() => MateriController());
  }
}
