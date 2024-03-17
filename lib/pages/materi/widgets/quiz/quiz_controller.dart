import 'package:chat_apps/models/answer.dart';
import 'package:chat_apps/models/quiz.dart';
import 'package:chat_apps/models/result.dart';
import 'package:chat_apps/models/topic.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  RxBool loading = false.obs;
  RxBool proccess = false.obs;
  late ApiService apiService = ApiService();
  late List<ResultTopic> resulttopic = [];
  late List<ResultQuiz> resultQuiz = [];
  late ResultAnswer resultAnswer;
  late ResultModul ress;

  Future<void> fecthtopic({batch, jenjang, uid, materiid}) async {
    try {
      loading.value = true;
      var res = await apiService.fetchTopic(
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
      var res = await apiService.fetchQuizByTopic(topicid: topicid);
      resultQuiz = res.result;
      proccess.value = false;
      print(res.result.length);
    } catch (e) {
      print(e);
      proccess.value = false;
    }
  }

  Future<bool> fetchAnswer({String? uid, String? topicid}) async {
    try {
      proccess.value = true;
      var res = await apiService.fetchAnswer(uid: uid, topicid: topicid);
      if (res.status) {
        resultAnswer = res.result[0];
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

  Future<bool> submitquiz({uid, topicid, corret, incorret, quiz}) async {
    try {
      var res = await apiService.submitQuiz(
          uid: uid,
          topicid: topicid,
          corret: corret,
          incorret: incorret,
          quiz: quiz);
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
