import 'package:chat_apps/models/answeresay.dart';
import 'package:chat_apps/models/esay.dart';
import 'package:chat_apps/models/result.dart';
import 'package:chat_apps/models/topic.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EsayController extends GetxController {
  RxBool loading = false.obs;
  RxBool proccess = false.obs;
  late ApiService apiService = ApiService();
  late List<ResultTopic> resulttopic = [];
  late List<ResultEsay> resultEsay = [];
  late List<ResultAnswerEsay> resultAnswer = [];
  late ResultModul ress;
  final answerController = TextEditingController();

  Future<void> fecthtopic({batch, jenjang, uid, materiid}) async {
    try {
      loading.value = true;
      var res = await apiService.fetchTopicEsay(
          batch: batch, jenjang: jenjang, uid: uid, materiid: materiid);
      resulttopic = res.result;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> fetchquizbytopic({int? topicid}) async {
    try {
      proccess.value = true;
      var res = await apiService.fetchEsayByTopic(topicid: topicid);
      resultEsay = res.result;
      proccess.value = false;
    } catch (e) {
      proccess.value = false;
    }
  }

  Future<bool> fetchAnswer({String? uid, String? topicid}) async {
    try {
      proccess.value = true;
      var res = await apiService.fetchAnswerEsay(uid: uid, topicid: topicid);

      if (res.status) {
        resultAnswer = res.result;
        proccess.value = false;
        return true;
      } else {
        proccess.value = false;
        return false;
      }
    } catch (e) {
      proccess.value = false;
      return false;
    }
  }

  Future<bool> submitquiz({uid, topicid}) async {
    try {
      var res = await apiService.submitEsay(
          uid: uid, topicid: topicid, esay: resultEsay);
      ress = res;
      if (res.status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
