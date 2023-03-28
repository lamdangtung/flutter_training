import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
