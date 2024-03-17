import 'package:chat_apps/models/sertifikat.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:get/get.dart';

class SertifikatController extends GetxController {
  late ApiService apiService = ApiService();
  RxBool proccess = false.obs;
  RxBool empty = false.obs;
  late List<ResultSertifikat> resultSertifikat;

  Future<void> fetchSertifikat({uid}) async {
    try {
      proccess.value = true;
      var res = await apiService.fetchSertifikat(uid: uid);
      resultSertifikat = res.result;
      proccess.value = false;
    } catch (e) {
      proccess.value = false;
    }
  }
}
