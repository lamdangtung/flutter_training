import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/c4_homework/widgets/list_item.dart';
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
  Widget listBuilder = SVGListBuilder();
  Widget videoBuilder = YoutubeVideoWrapper();
  var isUsingSVG = true;
  var isUsingYoutube = true;
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
                                listBuilder = SVGListBuilder();
                              } else {
                                listBuilder = PNGListBuilder();
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
                  listBuilder
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
                            videoBuilder = YoutubeVideoWrapper();
                          } else {
                            videoBuilder = UrlVideoWrapper();
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
