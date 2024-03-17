import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/pages/materi/materi_controller.dart';
import 'package:chat_apps/pages/materi/widgets/videos/videos_controller.dart';
import 'package:chat_apps/widget/date_util.dart';
import 'package:chat_apps/widget/presistentheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> with TickerProviderStateMixin {
  MateriController materiController = Get.find<MateriController>();
  VideosController videosController = Get.put(VideosController());
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    getVideos();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  getVideos() async {
    await videosController.fecthvideos(
        materiid: materiController.resultMateri.id.toString());
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshVideos,
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
            () => videosController.loading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: PersistentHeader("Pengalaman Konkrit"),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          List.generate(
                            videosController.resultvideos.length,
                            (idx) {
                              final int count =
                                  videosController.resultvideos.length > 10
                                      ? 10
                                      : videosController.resultvideos.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * idx, 1.0,
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
                                        color: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6.0, vertical: 6.0),
                                        child: InkWell(
                                          onTap: () async {
                                            videosController.postRead(
                                                id: videosController
                                                    .resultvideos[idx].id);
                                            await Get.toNamed('/youtube',
                                                arguments: [
                                                  videosController
                                                      .resultvideos[idx]
                                                ]);
                                          },
                                          splashColor: Colors.transparent,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.6),
                                                  offset: const Offset(4, 4),
                                                  blurRadius: 16,
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16.0)),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      AspectRatio(
                                                          aspectRatio: 2,
                                                          child: Stack(
                                                            children: [
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child:
                                                                    CachedNetworkImage(
                                                                        imageUrl: videosController
                                                                            .resultvideos[
                                                                                idx]
                                                                            .thumbnail
                                                                            .medium
                                                                            .url,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        placeholder: (context,
                                                                                url) =>
                                                                            SizedBox(
                                                                              height: MediaQuery.of(context).size.height / 3.2,
                                                                              child: const Center(
                                                                                child: CircularProgressIndicator(),
                                                                              ),
                                                                            ),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            Image.asset(
                                                                              'assets/images/ic-bgactivity.png',
                                                                              height: MediaQuery.of(context).size.height / 3.2,
                                                                              width: MediaQuery.of(context).size.width,
                                                                              fit: BoxFit.fill,
                                                                            )),
                                                              ),
                                                              Positioned(
                                                                  top: 10,
                                                                  bottom: 0,
                                                                  left: 0,
                                                                  right: 0,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/icons/ic-play.png',
                                                                    height: 25,
                                                                    width: 25,
                                                                    scale: 4,
                                                                  ))
                                                            ],
                                                          )),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    30,
                                                                child: Text(
                                                                  videosController
                                                                      .resultvideos[
                                                                          idx]
                                                                      .title,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                )),
                                                            Row(
                                                              children: [
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              6.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove_red_eye,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 14.0,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 50,
                                                                  child: Text(
                                                                    videosController
                                                                        .resultvideos[
                                                                            idx]
                                                                        .read
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10.0),
                                                                  ),
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              6.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .access_time,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 14.0,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  timeAgo(DateTime.parse(
                                                                      videosController
                                                                          .resultvideos[
                                                                              idx]
                                                                          .date)),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10.0),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshVideos() async {}
}
