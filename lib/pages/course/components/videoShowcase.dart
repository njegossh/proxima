import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videoshowcase extends StatefulWidget {
  final videoURL;
  const Videoshowcase({super.key, this.videoURL});

  @override
  State<Videoshowcase> createState() => _VideoshowcaseState();
}

class _VideoshowcaseState extends State<Videoshowcase> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.videoURL);

    if (videoID != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
              ? YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                )
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
      ),
    );
  }
}
