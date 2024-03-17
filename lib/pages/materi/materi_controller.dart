import 'package:chat_apps/models/materi.dart';
import 'package:chat_apps/pages/materi/widgets/quiz/quiz.dart';
import 'package:chat_apps/pages/materi/widgets/videos/videos.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/easy/easy.dart';
import 'widgets/eksperimen/eksperimen.dart';
import 'widgets/eksperimen/eksperimen_controller.dart';

class MateriController extends GetxController {
  EksperimenController eksperimenController = Get.put(EksperimenController());
  MoreController moreController = Get.put(MoreController());
  RxBool loading = false.obs;
  RxInt read = 0.obs;
  late ApiService apiService = ApiService();
  late List<ResultMateri> resultMateris = [];
  late ResultMateri resultMateri;
  RxInt activeMenu = 0.obs;

  final key = GlobalKey();
  onMenuTapped(index) {
    activeMenu.value = index;
  }

  Widget activeScreen() {
    switch (activeMenu.value) {
      case 0:
        return const VideosPage();
      case 1:
        return const QuizPage();
      case 2:
        return const EasyPage();
      case 3:
        return const EksperimenPage();
      default:
        return const VideosPage();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fecthmateri();
  }

  Future<void> fecthmateri() async {
    try {
      loading.value = true;
      var res = await apiService.fetchMateri();
      resultMateris = res.result;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }
}
