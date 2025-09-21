import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
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
            padding: EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              "Learn more".tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: widget.videoURL != null
                  ? YoutubePlayer(controller: _controller)
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.slow_motion_video_outlined,
                            size: 50,
                            color: Colors.indigo,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "No course video!".tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}