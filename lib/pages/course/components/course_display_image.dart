import 'dart:convert';
import 'package:flutter/material.dart';

class CourseDisplayImage extends StatelessWidget {
  final String? imageString;
  const CourseDisplayImage({super.key, this.imageString});

  bool _isBase64(String? str) {
    if (str == null || str.isEmpty) return false;
    return !str.startsWith('http') && str.length > 50;
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageString == null || imageString!.isEmpty) {
      imageWidget = const Icon(Icons.image_rounded, size: 100);
    } else if (_isBase64(imageString)) {
      try {
        final bytes = base64Decode(imageString!);
        imageWidget = Image.memory(
          bytes,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 100),
        );
      } catch (_) {
        imageWidget = const Icon(Icons.broken_image, size: 100);
      }
    } else {
      imageWidget = const Icon(Icons.broken_image, size: 100);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: SizedBox(
          width: double.infinity,
          height: 220,
          child: imageWidget,
        ),
      ),
    );
  }
}
