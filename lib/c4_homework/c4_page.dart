import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/c4_homework/widgets/title_item.dart';
import 'package:flutter_training/c4_homework/widgets/png_list_builder.dart';
import 'package:flutter_training/c4_homework/widgets/svg_list_builder.dart';
import 'package:flutter_training/c4_homework/widgets/url_video_wrapper.dart';
import 'package:flutter_training/c4_homework/widgets/youtube_video_wrapper.dart';
import 'package:flutter_training/utils/app_images.dart';
import 'package:flutter_training/utils/constant.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class C4Page extends StatefulWidget {
  const C4Page({super.key});

  static const titles = ["FAQ", "Contact Us", "Terms & Condition"];

  @override
  State<C4Page> createState() => _C4PageState();
}

class _C4PageState extends State<C4Page> {
  late Widget titlesBuilder = SVGListBuilder();
  late Widget videoBuilder;
  var isUsingSVG = true;
  var isUsingYoutube = true;
  late YoutubePlayerController youtubeController;
  late VideoPlayerController urlVideoController;
  final urlVideo =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  var isLoaded = false;
  var currentPositon = 0;
  @override
  void initState() {
    super.initState();
    youtubeController = YoutubePlayerController(
      initialVideoId: 'YBRkVCRP1Gw',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );

    videoBuilder = YoutubeVideoWrapper(controller: youtubeController);

    urlVideoController = VideoPlayerController.network(urlVideo)
      ..initialize().then((_) {
        setState(() {
          isLoaded = true;
          urlVideoController.play();
        });
      });
    urlVideoController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    youtubeController.dispose();
    urlVideoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isUsingSVG = !isUsingSVG;
                              if (isUsingSVG) {
                                titlesBuilder = SVGListBuilder();
                              } else {
                                titlesBuilder = PNGListBuilder();
                              }
                            });
                          },
                          child: const Text(
                            "Switch",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(isUsingSVG ? "SVG" : "PNG"),
                      ],
                    ),
                  ),
                  titlesBuilder
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isUsingYoutube = !isUsingYoutube;
                          if (isUsingYoutube) {
                            videoBuilder = YoutubeVideoWrapper(
                              controller: youtubeController,
                            );
                            urlVideoController.pause();
                            youtubeController.seekTo(
                              Duration(seconds: currentPositon),
                            );
                            youtubeController.play();
                          } else {
                            videoBuilder = UrlVideoWrapper(
                              controller: urlVideoController,
                              isLoaded: isLoaded,
                            );
                            urlVideoController.play();
                            youtubeController.pause();
                            currentPositon =
                                youtubeController.value.position.inSeconds;
                          }
                        });
                      },
                      child: const Text(
                        "Switch",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(isUsingYoutube ? "Youtube" : "URL"),
                    Expanded(child: videoBuilder),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
