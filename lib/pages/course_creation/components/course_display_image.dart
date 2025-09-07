import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class CourseDisplayImage extends StatelessWidget {
  final String? displayImageString;

  const CourseDisplayImage({
    super.key,
    this.displayImageString,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: double.infinity,
        height: 220,
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (displayImageString != null && displayImageString!.isNotEmpty) {
      try {
        final Uint8List bytes = base64Decode(displayImageString!);
        return Image.memory(
          bytes,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      } catch (e) {
        debugPrint("Invalid base64 string: $e");
      }
    }

    return _fallbackIcon();
  }

  Widget _fallbackIcon() {
    return const Center(
      child: Icon(
        Icons.image_rounded,
        size: 100,
        color: Colors.grey,
      ),
    );
  }
}
