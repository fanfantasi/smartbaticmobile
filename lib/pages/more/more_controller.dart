import 'package:chat_apps/models/users.dart';
import 'package:chat_apps/services/api_service.dart';
import 'package:chat_apps/services/googlesignin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {
  RxBool prossess = false.obs;
  RxString? name = ''.obs;
  RxString? email = ''.obs;
  RxString? uid = ''.obs;
  RxString? avatar = ''.obs;
  RxBool isAvatar = false.obs;
  late ApiService apiService = ApiService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ResultUser usersModel;
  RxBool isActive = true.obs;

  @override
  void onInit() {
    super.onInit();
    getUserGmail();
  }

  Future<void> getUserGmail() async {
    prossess.value = true;
    User firebaseUser = FirebaseAuth.instance.currentUser!;

    uid?.value = firebaseUser.uid;

    await checkStatus(firebaseUser);
  }

  Future<void> checkStatus(User firebaseUser) async {
    try {
      var res = await apiService.checkLogin(uid: firebaseUser.uid);
      if (res.status) {
        usersModel = res.result[0];
        name?.value = usersModel.displayname;
        email?.value = usersModel.email;
        if (usersModel.avatar.isEmpty) {
          isAvatar.value = false;
          avatar?.value = firebaseUser.photoURL!;
        } else {
          avatar?.value = usersModel.avatar;
          isAvatar.value = true;
        }
        if (usersModel.active == 0) {
          isActive.value = false;
        } else {
          isActive.value = true;
        }
      } else {
        isActive.value = false;
      }
      prossess.value = false;
    } catch (e) {
      prossess.value = false;
      Fluttertoast.showToast(msg: 'Error Connection');
      signOut();
    }
  }

  Future<void> signOut() async {
    Future.delayed(Duration.zero, () async {
      GoogleSignApi.logout();
      await _auth.signOut();
      await Get.offAllNamed("/signup");
    });
  }
}
