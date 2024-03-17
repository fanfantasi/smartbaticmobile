import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/pages/materi/materi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MateriBar extends GetView<MateriController> {
  const MateriBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.resultMateri.materi),
        actions: [
          Obx(
            () => controller.activeMenu.value == 3
                ? InkWell(
                    onTap: () async {
                      var res = await Get.toNamed('/uploadeksperimen');
                      if (res) {
                        await controller.eksperimenController.fetchGallery(
                            materiid: controller.resultMateri.id.toString(),
                            uid: controller.moreController.usersModel.uid);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 12.0),
                      child: const Text('Tambah Photo'),
                    ),
                  )
                : Container(),
          )
        ],
      ),
      body: Obx(() => controller.activeScreen()),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          elevation: 0,
          currentIndex: controller.activeMenu.value,
          onTap: controller.onMenuTapped,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset(
                  'assets/icons/ic-videos.png',
                  width: 24,
                  height: 24,
                  color: controller.activeMenu.value == 0
                      ? kPrimaryColor
                      : const Color(0xFF626B79),
                ),
              ),
              label: 'Videos',
            ),
            BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Image.asset(
                    'assets/icons/ic-books.png',
                    width: 24,
                    height: 24,
                    color: controller.activeMenu.value == 1
                        ? kPrimaryColor
                        : const Color(0xFF626B79),
                  ),
                ),
                label: 'Quiz'),
            BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Image.asset(
                    'assets/icons/ic-quiz.png',
                    width: 24,
                    height: 24,
                    color: controller.activeMenu.value == 2
                        ? kPrimaryColor
                        : const Color(0xFF626B79),
                  ),
                ),
                label: 'Esay'),
            BottomNavigationBarItem(
                icon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Icon(
                      Icons.upload,
                      size: 24,
                      color: controller.activeMenu.value == 3
                          ? kPrimaryColor
                          : const Color(0xFF626B79),
                    )),
                label: 'Upload'),
          ],
        ),
      ),
    );
  }
}
