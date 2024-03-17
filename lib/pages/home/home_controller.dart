import 'package:chat_apps/models/banners.dart';
import 'package:chat_apps/models/modules.dart';
import 'package:chat_apps/models/read.dart';
import 'package:chat_apps/models/videos.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  RxInt read = 0.obs;
  late ApiService apiService = ApiService();
  late List<ResultBanners> resultbanners = [];
  late List<ResultModules> resultmodules = [];
  late List<ResultVideos> resultvideos = [];
  late ReadModul resultRead;

  Future<void> fecthBanner() async {
    try {
      loading.value = true;
      var res = await apiService.fetchBanners();
      resultbanners = res.result;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> fecthmodules({batch, jenjang}) async {
    try {
      loading.value = true;
      var res = await apiService.fetchModules(batch: batch, jenjang: jenjang);
      resultmodules = res.result;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> postRead({id}) async {
    try {
      var res = await apiService.postReadModule(id: id);
      if (res.status) {
        resultRead = res;
        read.value = resultRead.data;
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
