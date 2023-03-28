import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UrlVideoWrapper extends StatelessWidget {
  const UrlVideoWrapper({
    super.key,
    required this.controller,
    required this.isLoaded,
  });

  final VideoPlayerController controller;

  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: isLoaded
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(
                  controller,
                ),
              )
            : const CircularProgressIndicator());
  }
}
