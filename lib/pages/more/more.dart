import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:chat_apps/pages/sertifikat/sertifikat_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  MoreController moreController = Get.put(MoreController());
  SertifikatController sertifikatController = Get.put(SertifikatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => (moreController.prossess.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        child: Column(
                          children: [
                            Center(
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: kPrimaryColor,
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundImage: NetworkImage(
                                          '${moreController.avatar ?? ''}'),
                                    ))),
                            const SizedBox(height: 10),
                            Text('${moreController.name}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14)),
                            // const SizedBox(height: 10),
                            Text('${moreController.email}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                color: Colors.white,
                child: ListTile(
                  title: const Text('Edit Profil'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: Color(0xFF4B61DD),
                  ),
                  onTap: () async {
                    var res = await Get.toNamed('/profil');
                    if (res) {
                      await moreController.getUserGmail();
                    }
                  },
                ),
              ),
              const Divider(
                height: 1,
                indent: 16.0,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                color: Colors.white,
                child: ListTile(
                  title: const Text('Hasil Membatik'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: Color(0xFF4B61DD),
                  ),
                  onTap: () {
                    Get.toNamed('/portfoliosiswa');
                  },
                ),
              ),
              const Divider(
                height: 1,
                indent: 16.0,
              ),
              Container(
                margin: const EdgeInsets.only(top: 0.0),
                color: Colors.white,
                child: ListTile(
                  title: Text((moreController.usersModel.level == 1)
                      ? 'Sertifikat'
                      : 'Portofolio'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: Color(0xFF4B61DD),
                  ),
                  onTap: () async {
                    if (moreController.usersModel.level == 1) {
                      await sertifikatController.fetchSertifikat(
                          uid: moreController.usersModel.uid);
                      if (sertifikatController.resultSertifikat.isNotEmpty) {
                        await Get.toNamed('/viewpdf', arguments: [
                          sertifikatController.resultSertifikat[0],
                          sertifikatController.resultSertifikat[0].sertifikat
                        ]);
                      } else {
                        Get.snackbar('error', 'Anda Belum memiliki sertifikat',
                            colorText: Colors.black54,
                            backgroundColor: kPrimaryColor.withOpacity(0.3),
                            margin: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            titleText: const Text(
                              'Informasi',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ));
                      }
                    } else {
                      Get.toNamed('/portfolioguru');
                    }
                  },
                ),
              ),
              const Divider(
                height: 1,
                indent: 16.0,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  color: Colors.white,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await Get.dialog(CupertinoAlertDialog(
                          title: const Text('Keluar'),
                          content: const Text(
                              'Apakah yakin akan keluar dari aplikasi Smart Batik Class?'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("Batal"),
                              onPressed: () {
                                Get.back(result: false);
                              },
                            ),
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("Ya"),
                              onPressed: () async {
                                Get.back(result: false);
                                // LoadingDialog.showLoadingDialog(context, key);
                                await moreController.signOut();
                              },
                            )
                          ],
                        ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Keluar',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
