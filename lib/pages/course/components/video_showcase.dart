import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Videoshowcase extends StatefulWidget {
  const Videoshowcase({super.key, this.videoURL});

  final String? videoURL;

  @override
  State<Videoshowcase> createState() => _VideoshowcaseState();
}

class _VideoshowcaseState extends State<Videoshowcase> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    final String? videoId = YoutubePlayerController.convertUrlToId(widget.videoURL ?? '');
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId ?? '',
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              "Saznajte vise:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        widget.videoURL != null
            ? YoutubePlayer(controller: _controller)
            : Column(
                children: [
                  Text(
                    "Jos uvek nema dodatnog videa za ovaj kurs!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.slow_motion_video_outlined,
                    size: 50,
                    color: Colors.indigo,
                  ),
                ],
              ),
      ],
    );
  }
}
