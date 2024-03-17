import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/constanta/utilities.dart';
import 'package:chat_apps/pages/error/inactive.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:chat_apps/pages/profil/profil_controller.dart';
import 'package:chat_apps/services/permissions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  MoreController moreController = Get.put(MoreController());
  ProfilController profilController = Get.put(ProfilController());
  File? imageFile;

  showFilePicker(FileType fileType) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      String? path = result.files.single.path;
      if (!mounted) return;
      checkFileSize(path!);
    }
  }

  final _formKey = GlobalKey<FormState>();

  checkFileSize(String path) async {
    List<String> _naming = path.split('.');
    String _extension = _naming[_naming.length - 1];

    switch (Utilities.getFileType(_extension)) {
      case fileImage:
        setState(() {
          imageFile = File(path);
          profilController.photo.value = '';
          profilController.emptyphoto.value = false;
        });
        break;
      default:
        setState(() {
          imageFile = null;
        });
        profilController.photo.value = '';
        profilController.emptyphoto.value = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Obx(() => (moreController.isActive.value)
          ? Stack(
              children: [
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    decoration: const BoxDecoration(color: kPrimaryColor),
                    height: 200,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 12.0),
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                      child: Form(key: _formKey, child: _getFrom())),
                )
              ],
            )
          : const InactivePage()),
    );
  }

  Widget _getFrom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 90.0,
            width: 90.0,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                      padding: const EdgeInsets.all(2.0),
                      height: 90.0,
                      width: 90.0,
                      child: Obx(() => (profilController.photo.value != '')
                          ? CachedNetworkImage(
                              imageUrl: profilController.photo.value,
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(70.0)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                              errorWidget: (context, url, error) => Image.asset(
                                    'assets/icons/ic-bgactivity.png',
                                    height: 90.0,
                                  ))
                          : (imageFile == null)
                              ? Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(70.0)),
                                  ),
                                )
                              : Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(70.0)),
                                    image: DecorationImage(
                                        image: FileImage(imageFile!),
                                        fit: BoxFit.cover),
                                  ),
                                ))),
                ),
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Obx(
                      () => (profilController.emptyphoto.value)
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 12.0),
                              height: 90.0,
                              width: 100.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Add Photo',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async => await Permissions
                                            .storagePermissionsGranted()
                                        ? showFilePicker(FileType.any)
                                        : {},
                                  ),
                                ],
                              ))
                          : Container(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageFile = null;
                                  });
                                  profilController.photo.value = '';
                                  profilController.emptyphoto.value = true;
                                },
                                child: const Icon(
                                  CupertinoIcons.clear_circled_solid,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ))
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 18.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(width: .5, color: Colors.grey)),
          child: TextFormField(
            autofocus: true,
            maxLines: null,
            enabled: false,
            style: const TextStyle(color: Colors.grey),
            controller: profilController.emailController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(fontSize: 14.0),
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 18.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(width: .5, color: Colors.grey)),
          child: TextFormField(
            autofocus: true,
            maxLines: null,
            controller: profilController.nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              labelStyle: TextStyle(fontSize: 14.0),
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 18.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(width: .5, color: Colors.grey)),
          child: TextFormField(
            autofocus: true,
            maxLines: null,
            controller: profilController.nisController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'NIS atau NIM',
              labelStyle: TextStyle(fontSize: 14.0),
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 18.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(width: .5, color: Colors.grey)),
          child: TextFormField(
            autofocus: true,
            maxLines: null,
            style: const TextStyle(color: Colors.grey),
            enabled: false,
            controller: profilController.jenjangController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Jenjang Pendidikan',
              labelStyle: TextStyle(fontSize: 14.0),
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 18.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(width: .5, color: Colors.grey)),
          child: TextFormField(
            autofocus: true,
            maxLines: null,
            style: const TextStyle(color: Colors.grey),
            enabled: false,
            controller: profilController.sekolahController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Sekolah',
              labelStyle: TextStyle(fontSize: 14.0),
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 18.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(width: .5, color: Colors.grey)),
          child: TextFormField(
            autofocus: true,
            maxLines: null,
            controller: profilController.jurusanController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Jurusan / Program Studi',
              labelStyle: TextStyle(fontSize: 14.0),
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
          ),
        ),
        Obx(() => (profilController.submit.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: ElevatedButton(
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        profilController.submitProfil(
                            uid: moreController.usersModel.uid,
                            avatar: imageFile,
                            photourl: moreController.usersModel.avatar);
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
              ))
      ],
    );
  }
}
