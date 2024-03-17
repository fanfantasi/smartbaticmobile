import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_apps/constanta/utilities.dart';
import 'package:chat_apps/pages/materi/widgets/eksperimen/eksperimen_controller.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:chat_apps/pages/portfolio/gallery_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../materi_controller.dart';

class EksperimenPage extends StatefulWidget {
  const EksperimenPage({Key? key}) : super(key: key);

  @override
  State<EksperimenPage> createState() => _EksperimenPageState();
}

class _EksperimenPageState extends State<EksperimenPage> {
  EksperimenController eksperimenController = Get.find<EksperimenController>();
  MateriController materiController = Get.find<MateriController>();
  MoreController moreController = Get.find<MoreController>();
  bool verticalGallery = false;

  @override
  void initState() {
    eksperimenController.fetchGallery(
        uid: moreController.usersModel.uid,
        materiid: materiController.resultMateri.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => (eksperimenController.empty.value)
        ? const Center(
            child: Text(
              'Media masih kosong',
              style: TextStyle(fontSize: 20),
            ),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() => (eksperimenController.proccess.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : listHeaderWidget()),
          ));
  }

  Widget listHeaderWidget() {
    List<Widget> _listWidget = [];
    List<String> _imageUrls = [];
    eksperimenController.resultgallery.asMap().forEach((index, gallery) {
      if (index == 0) {
        _listWidget.add(
          Container(
            padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
            width: double.infinity,
            child: Text(
              Utilities.dateMonthYear(DateTime.parse(gallery.date)),
              style: const TextStyle(color: Color(0xff595959)),
            ),
          ),
        );
      } else {
        _imageUrls.add(gallery.image);
        if (Utilities.dateMonthYear(DateTime.parse(gallery.date)) !=
            Utilities.dateMonthYear(DateTime.parse(
                eksperimenController.resultgallery[index - 1].date))) {
          _listWidget.add(
            Container(
              padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
              width: double.infinity,
              child: Text(
                Utilities.dateMonthYear(DateTime.parse(gallery.date)),
                style: const TextStyle(color: Color(0xff595959)),
              ),
            ),
          );
        }
      }
      _listWidget.add(Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 4,
        child: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: gallery.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Image.asset(
                  'assets/images/ic-bgactivity.png',
                  fit: BoxFit.cover),
            ),
          ),
          onTap: () {
            Get.generalDialog(
              barrierLabel: "imageviewer",
              barrierDismissible: false,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 100),
              pageBuilder: (context, anim1, anim2) {
                return GalleryPhotoViewWrapper(
                  galleryItems: eksperimenController.resultgallery,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.black),
                  initialIndex: index,
                  scrollDirection:
                      verticalGallery ? Axis.vertical : Axis.horizontal,
                );
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position:
                      Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                          .animate(anim1),
                  child: child,
                );
              },
            );
          },
        ),
      ));
    });
    return Wrap(children: _listWidget);
  }
}
