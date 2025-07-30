import 'package:flutter/material.dart';
import 'package:proxima/pages/class/components/courseDisplayImage.dart';

class VideoShowcase extends StatelessWidget { //TO BE COMPLETED
  const VideoShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4),
      child: Column(
        children: [Padding(padding: EdgeInsets.all(4), child: Coursedisplayimage())],
      ),
    );
  }
}
