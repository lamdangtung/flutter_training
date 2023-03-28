import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
