import 'package:chat_apps/models/read.dart';
import 'package:chat_apps/models/videos.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:get/get.dart';

class VideosController extends GetxController {
  RxBool loading = false.obs;
  RxInt read = 0.obs;
  late ApiService apiService = ApiService();
  late List<ResultVideos> resultvideos = [];
  late ReadModul resultRead;

  Future<void> fecthvideos({String? materiid}) async {
    try {
      loading.value = true;
      var res = await apiService.fetchVideos(materiid: materiid);
      resultvideos = res.result;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> postRead({id}) async {
    try {
      var res = await apiService.postReadVideo(id: id);
      if (res.status) {
        resultRead = res;
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
