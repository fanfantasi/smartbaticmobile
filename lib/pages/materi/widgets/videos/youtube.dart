import 'package:chat_apps/models/videos.dart';
import 'package:chat_apps/widget/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePage extends StatefulWidget {
  const YoutubePage({Key? key}) : super(key: key);

  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  late YoutubePlayerController _controller;
  late ResultVideos resultVideos;

  @override
  void initState() {
    resultVideos = Get.arguments[0];
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: resultVideos.url,
      params: const YoutubePlayerParams(
        startAt: Duration(minutes: 0, seconds: 00),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _controller.onExitFullscreen = () {};
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Video Pembelajaran'),
          ),
          body: ListView(children: [
            Stack(
              children: [
                player,
                Positioned.fill(
                  child: YoutubeValueBuilder(
                    controller: _controller,
                    builder: (context, value) {
                      return AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Material(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  YoutubePlayerController.getThumbnail(
                                    videoId: resultVideos.url,
                                    quality: ThumbnailQuality.medium,
                                  ),
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        crossFadeState: value.isReady
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 30,
                        child: Text(
                          resultVideos.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        )),
                    Text('Batch ${resultVideos.batch}'),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 6.0),
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                            size: 14.0,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(
                            resultVideos.read.toString(),
                            style: const TextStyle(fontSize: 10.0),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 6.0),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 14.0,
                          ),
                        ),
                        Text(
                          timeAgo(DateTime.parse(resultVideos.date)),
                          style: const TextStyle(fontSize: 10.0),
                        ),
                      ],
                    )
                  ],
                )),
          ])),
    );
  }
}
