import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:proxima/main.dart';

class CourseImageSection extends StatelessWidget {
  final String? imageString;
  final VoidCallback onPickImage;

  const CourseImageSection({
    super.key,
    required this.imageString,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget displayImage() {
      if (imageString != null && imageString!.isNotEmpty) {
        try {
          final Uint8List bytes = base64Decode(imageString!);
          return Image.memory(
            bytes,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          );
        } catch (_) {}
      }
      return const SizedBox(
        height: 200,
        child: Icon(Icons.image_rounded, size: 100),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: colorScheme.surface.withValues(alpha: 0.3),
              height: 200,
              width: double.infinity,
              child: displayImage(),
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onPickImage,
            icon: const Icon(Icons.camera_alt),
            label: Text(
              imageString == null ? "Choose photo".tr : "Change photo".tr,
            ),
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.surface,
            ), 
          ),
        ],
      ),
    );
  }
}
