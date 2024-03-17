import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/pages/error/inactive.dart';
import 'package:chat_apps/pages/home/home_controller.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:chat_apps/widget/custom_slider.dart';
import 'package:chat_apps/widget/date_util.dart';
import 'package:chat_apps/widget/presistentheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MoreController moreController = Get.put(MoreController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _getBanner().then((value) {
      if (value) {
        if ((moreController.isActive.value && !moreController.prossess.value)) {
          homeController.fecthmodules(
            batch: moreController.usersModel.batch,
            jenjang: moreController.usersModel.jenjang,
          );
          // videosController.fecthvideos();
          // quizController.fecthtopic(
          //     batch: moreController.usersModel.batch,
          //     jenjang: moreController.usersModel.jenjang,
          //     uid: moreController.usersModel.uid);
        }
      }
    });
  }

  Future<bool> _getBanner() async {
    await moreController.getUserGmail();
    await homeController.fecthBanner();
    return true;
  }

  Future<void> _refreshmodule() async {
    await homeController.fecthmodules(
      batch: moreController.usersModel.batch,
      jenjang: moreController.usersModel.jenjang,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            scale: 6,
          ),
          actions: [
            Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                    onTap: () {
                      // homeController.getUser();
                      // homeController.getUserGmail();
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            radius: 17,
                            child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.yellow[800],
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${moreController.avatar ?? ''}'),
                                )))))),
          ],
        ),
        body: Obx(() => (moreController.isActive.value)
            ? RefreshIndicator(
                onRefresh: _refreshmodule,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        decoration: const BoxDecoration(color: kPrimaryColor),
                        height: 200,
                      ),
                    ),
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverList(
                            delegate: SliverChildListDelegate([
                          (homeController.loading.value)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomSliderWidget(
                                  items: homeController.resultbanners.toList()),
                          const SizedBox(
                            height: 12.0,
                          ),
                        ])),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: PersistentHeader("Module Pembelajaran"),
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate(List.generate(
                                homeController.resultmodules.length, (idx) {
                          homeController.read.value =
                              homeController.resultmodules[idx].read;
                          return InkWell(
                            onTap: () async {
                              homeController.postRead(
                                  id: homeController.resultmodules[idx].id);

                              await Get.toNamed('/pdfviewer', arguments: [
                                homeController.resultmodules[idx],
                                homeController.resultmodules[idx].file
                              ]);
                            },
                            child: Container(
                                color: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'assets/icons/ic-pdf.png',
                                            scale: 9,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      130,
                                                  child: Text(
                                                    homeController
                                                        .resultmodules[idx]
                                                        .title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                              Text(kelompok(homeController
                                                  .resultmodules[idx].batch)),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 6.0),
                                                    child: Icon(
                                                      Icons.remove_red_eye,
                                                      color: Colors.grey,
                                                      size: 14.0,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    child: Text(
                                                      homeController.read
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 10.0),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 6.0),
                                                    child: Icon(
                                                      Icons.access_time,
                                                      color: Colors.grey,
                                                      size: 14.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    timeAgo(DateTime.parse(
                                                        homeController
                                                            .resultmodules[idx]
                                                            .date)),
                                                    style: const TextStyle(
                                                        fontSize: 10.0),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const IconButton(
                                              onPressed: null,
                                              icon:
                                                  Icon(Icons.arrow_forward_ios))
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      indent: 8.0,
                                    )
                                  ],
                                )),
                          );
                        })))
                      ],
                    ),
                  ],
                ),
              )
            : const InactivePage()));
  }
}
