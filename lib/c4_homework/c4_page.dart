import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  ListBuilder listBuilder = SVGListBuilder();
  VideoBuilder videoBuilder = YoutubeVideoBuilder();
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
                  listBuilder.build(),
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
                            videoBuilder = YoutubeVideoBuilder();
                          } else {
                            videoBuilder = UrlVideoBuilder();
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
                    Expanded(child: videoBuilder.build()),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  const ListItem({super.key, required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          color: Colors.black12),
      margin: const EdgeInsets.all(kSmallPadding),
      padding: const EdgeInsets.all(kSmallPadding),
      child: Row(
        children: [
          leading,
          const SizedBox(
            width: kDefaultPadding,
          ),
          Expanded(child: trailing)
        ],
      ),
    );
  }
}

abstract class ListBuilder {
  Widget build();
}

class SVGListBuilder extends ListBuilder {
  static const icons = [AppImages.icFaq, AppImages.icGroup, AppImages.icTerms];

  @override
  Widget build() {
    return Column(
      children: icons
          .map(
            (e) => ListItem(
              leading: SvgPicture.asset(
                e,
                height: 36,
                width: 36,
              ),
              trailing: Text(C4Page.titles[icons.indexOf(e)]),
            ),
          )
          .toList(),
    );
  }
}

class PNGListBuilder extends ListBuilder {
  static const images = [
    AppImages.imgFaq,
    AppImages.imgGroup,
    AppImages.imgTerms
  ];

  @override
  Widget build() {
    return Column(
      children: images
          .map(
            (e) => ListItem(
              leading: Image.asset(
                e,
                height: 36,
                width: 36,
              ),
              trailing: Text(C4Page.titles[images.indexOf(e)]),
            ),
          )
          .toList(),
    );
  }
}

abstract class VideoBuilder {
  Widget build();
}

class YoutubeVideoBuilder extends VideoBuilder {
  @override
  Widget build() {
    return const Center(child: YoutubeVideoWrapper());
  }
}

class YoutubeVideoWrapper extends StatefulWidget {
  const YoutubeVideoWrapper({super.key});

  @override
  State<YoutubeVideoWrapper> createState() => _YoutubeVideoWrapperState();
}

class _YoutubeVideoWrapperState extends State<YoutubeVideoWrapper> {
  final urlVideo =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  late YoutubePlayerController _controller;
  var isLoaded = false;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: 'YBRkVCRP1Gw',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
  }
}

class UrlVideoBuilder extends VideoBuilder {
  @override
  Widget build() {
    return UrlVideoWrapper();
  }
}

class UrlVideoWrapper extends StatefulWidget {
  const UrlVideoWrapper({super.key});

  @override
  State<UrlVideoWrapper> createState() => _UrlVideoWrapperState();
}

class _UrlVideoWrapperState extends State<UrlVideoWrapper> {
  final urlVideo =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  late VideoPlayerController _controller;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(urlVideo)
      ..initialize().then((_) {
        setState(() {
          isLoaded = true;
          _controller.play();
        });
      });
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: isLoaded
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              )
            : const CircularProgressIndicator());
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
    }
  }
}
