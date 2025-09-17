import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/pages/course/main_page.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  bool _isBase64(String? str) {
    if (str == null || str.isEmpty) return false;
    return !str.startsWith('http') && str.length > 50;
  }

  Widget _buildImage(String? thumbnailString) {
    if (thumbnailString == null || thumbnailString.isEmpty) {
      return const Icon(Icons.image, size: 75);
    }

    if (_isBase64(thumbnailString)) {
      try {
        final bytes = base64Decode(thumbnailString);
        return Image.memory(
          bytes,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 75),
        );
      } catch (_) {
        return const Icon(Icons.broken_image, size: 75);
      }
    }

    return Image.network(
      thumbnailString,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 75),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(child: _buildImage(course.thumbnailString)),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Text(
                course.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  shadows: const [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black54,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseMainPage(course: course),
                    ),
                  );
                },
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}