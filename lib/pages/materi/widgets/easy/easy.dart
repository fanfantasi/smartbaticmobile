import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:chat_apps/widget/date_util.dart';
import 'package:chat_apps/widget/esay_options.dart';
import 'package:chat_apps/widget/presistentheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

import '../../materi_controller.dart';
import 'esay_controller.dart';

class EasyPage extends StatefulWidget {
  const EasyPage({Key? key}) : super(key: key);

  @override
  State<EasyPage> createState() => _EasyPageState();
}

class _EasyPageState extends State<EasyPage> with TickerProviderStateMixin {
  MateriController materiController = Get.find<MateriController>();
  MoreController moreController = Get.find<MoreController>();
  EsayController esayController = Get.put(EsayController());
  AnimationController? animationController;

  @override
  void initState() {
    // _getQuiz();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
    esayController.fecthtopic(
        batch: moreController.usersModel.batch,
        jenjang: moreController.usersModel.jenjang,
        uid: moreController.usersModel.uid,
        materiid: materiController.resultMateri.id.toString());
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<void> _refreshTopic() async {
    await esayController.fecthtopic(
        batch: moreController.usersModel.batch,
        jenjang: moreController.usersModel.jenjang,
        uid: moreController.usersModel.uid,
        materiid: materiController.resultMateri.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshTopic,
      child: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: const BoxDecoration(color: kPrimaryColor),
              height: 200,
            ),
          ),
          Obx(
            () => esayController.loading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: PersistentHeader("Eksperimen Aktif"),
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate(List.generate(
                                esayController.resulttopic.length, (idx) {
                          final int count =
                              esayController.resulttopic.length > 10
                                  ? 10
                                  : esayController.resulttopic.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval((1 / count) * idx, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController?.forward();
                          return AnimatedBuilder(
                              animation: animationController!,
                              builder: (BuildContext context, Widget? child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: Transform(
                                      transform: Matrix4.translationValues(0.0,
                                          50 * (1.0 - animation.value), 0.0),
                                      child: Container(
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0, vertical: 6.0),
                                          child: Card(
                                            elevation: 1.0,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0,
                                                        vertical: 6.0),
                                                leading: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              right: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey))),
                                                  child: const Icon(
                                                      Icons.library_books,
                                                      color: Colors.grey),
                                                ),
                                                title: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      esayController
                                                          .resulttopic[idx]
                                                          .thema,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const Divider()
                                                  ],
                                                ),
                                                subtitle: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        kelompok(esayController
                                                            .resulttopic[idx]
                                                            .batch),
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          6.0),
                                                              child: Icon(
                                                                Icons
                                                                    .access_time,
                                                                color:
                                                                    Colors.grey,
                                                                size: 14.0,
                                                              ),
                                                            ),
                                                            Text(
                                                              timeAgo(DateTime.parse(
                                                                  esayController
                                                                      .resulttopic[
                                                                          idx]
                                                                      .date)),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10.0),
                                                            ),
                                                          ],
                                                        )),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                6.5,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  kPrimaryColor,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12.0)),
                                                            ),
                                                            child: Text(
                                                              AppString.topic(
                                                                  esayController
                                                                      .resulttopic[
                                                                          idx]
                                                                      .active),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      10.0,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                trailing: const Icon(
                                                    Icons.keyboard_arrow_right,
                                                    color: Colors.grey,
                                                    size: 30.0),
                                                onTap: () async {
                                                  if (esayController
                                                          .resulttopic[idx]
                                                          .active ==
                                                      0) {
                                                    Get.snackbar('info',
                                                        'Soal Latihan ${esayController.resulttopic[idx].thema} belum dimulai',
                                                        colorText:
                                                            Colors.black54,
                                                        backgroundColor:
                                                            kPrimaryColor
                                                                .withOpacity(
                                                                    0.3),
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 12.0,
                                                            horizontal: 12.0),
                                                        titleText: const Text(
                                                          'Informasi',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ));
                                                  } else if (esayController
                                                          .resulttopic[idx]
                                                          .active ==
                                                      2) {
                                                    bool res = await esayController
                                                        .fetchAnswer(
                                                            uid: moreController
                                                                .usersModel.uid,
                                                            topicid:
                                                                esayController
                                                                    .resulttopic[
                                                                        idx]
                                                                    .id
                                                                    .toString());
                                                    if (res) {
                                                      Get.toNamed('/esayfinish',
                                                          arguments:
                                                              esayController
                                                                  .resulttopic[
                                                                      idx]
                                                                  .id);
                                                    } else {
                                                      Get.snackbar('info',
                                                          'Esay Sudah Selesai, Anda Tidak Mendapatkan Nilai Dari Esay Ini',
                                                          colorText:
                                                              Colors.black54,
                                                          backgroundColor:
                                                              kPrimaryColor
                                                                  .withOpacity(
                                                                      0.3),
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      12.0,
                                                                  horizontal:
                                                                      12.0),
                                                          titleText: const Text(
                                                            'Informasi',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ));
                                                    }
                                                  } else {
                                                    bool res = await esayController
                                                        .fetchAnswer(
                                                            uid: moreController
                                                                .usersModel.uid,
                                                            topicid:
                                                                esayController
                                                                    .resulttopic[
                                                                        idx]
                                                                    .id
                                                                    .toString());
                                                    if (res) {
                                                      Get.toNamed('/esayfinish',
                                                          arguments:
                                                              esayController
                                                                  .resulttopic[
                                                                      idx]
                                                                  .id);
                                                    } else {
                                                      _quizPressed(
                                                          context,
                                                          esayController
                                                              .resulttopic[idx]
                                                              .thema,
                                                          esayController
                                                              .resulttopic[idx]
                                                              .id);
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ))),
                                );
                              });
                        })))
                      ]),
          )
        ],
      ),
    );
  }

  _quizPressed(BuildContext context, String? title, int? topicid) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => EsayOptionsDialog(
          title: title,
          topicid: topicid,
        ),
        onClosing: () {},
      ),
    );
  }
}
