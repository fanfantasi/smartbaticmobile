import 'dart:io';

import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/constanta/utilities.dart';
import 'package:chat_apps/pages/materi/widgets/eksperimen/eksperimen_controller.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:chat_apps/services/permissions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../materi_controller.dart';

class UploadEksperimenPage extends StatefulWidget {
  const UploadEksperimenPage({Key? key}) : super(key: key);

  @override
  _UploadEksperimenPageState createState() => _UploadEksperimenPageState();
}

class _UploadEksperimenPageState extends State<UploadEksperimenPage> {
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  EksperimenController eksperimenController = Get.find<EksperimenController>();
  MateriController materiController = Get.find<MateriController>();
  MoreController moreController = Get.put(MoreController());
  final _formKey = GlobalKey<FormState>();

  openCameras() async {
    Navigator.of(context).pop();
    var photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      if (!mounted) return;
      checkFileSize(photo.path);
    }
  }

  @override
  void initState() {
    super.initState();
    eksperimenController.descController.clear();
  }

  showFilePicker(FileType fileType) async {
    Navigator.of(context).pop();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      String? path = result.files.single.path;
      if (!mounted) return;
      checkFileSize(path!);
    }
  }

  checkFileSize(String path) async {
    List<String> _naming = path.split('.');
    String _extension = _naming[_naming.length - 1];

    switch (Utilities.getFileType(_extension)) {
      case fileImage:
        setState(() {
          imageFile = File(path);
        });
        break;
      default:
        setState(() {
          imageFile = null;
        });
        Get.snackbar('Error', 'Photo yang dapat di upload hanya file gambar ',
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
        break;
    }
  }

  void addMediaModal(context) {
    final action = CupertinoActionSheet(
      actions: <Widget>[
        Material(
            child: Column(
          children: [
            InkWell(
              onTap: () {
                openCameras();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.photo_camera, color: Colors.blue[400]),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text(
                      "Camera",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async => await Permissions.storagePermissionsGranted()
                  ? showFilePicker(FileType.any)
                  : {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.photo, color: Colors.blue[400]),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text(
                      "Photo Library",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          "Cancel",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontFamily: 'Poppins', fontSize: 16),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload eksperimen aktif'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              (imageFile == null)
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: InkWell(
                          onTap: () {
                            addMediaModal(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.photo_camera,
                                color: Colors.grey,
                                size: 64,
                              ),
                              Text(
                                'Ambil Gambar',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          )),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        image: DecorationImage(
                            image: FileImage(imageFile!), fit: BoxFit.fill),
                      ),
                    ),
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    border: Border.all(width: .5, color: Colors.grey)),
                child: TextFormField(
                  autofocus: true,
                  maxLines: null,
                  minLines: 2,
                  style: const TextStyle(color: Colors.black),
                  controller: eksperimenController.descController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Keterangan Gambar',
                    labelStyle: TextStyle(fontSize: 14.0),
                    contentPadding: EdgeInsets.all(8.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Obx(() => (eksperimenController.submit.value)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: ElevatedButton(
                            child: const Text(
                              'Kirim Hasil Pembatik',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (imageFile == null) {
                                  Get.snackbar('error',
                                      'Gambar Belum Dipilih, silahkan ulangi',
                                      colorText: Colors.black54,
                                      backgroundColor:
                                          kPrimaryColor.withOpacity(0.3),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 12.0),
                                      titleText: const Text(
                                        'Informasi',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ));
                                } else {
                                  eksperimenController.submitGallery(
                                      sekolahid:
                                          moreController.usersModel.sekolahid,
                                      uid: moreController.usersModel.uid,
                                      materiid:
                                          materiController.resultMateri.id,
                                      photo: imageFile);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
