import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';

class CourseCarousel extends StatelessWidget {
  final List<Course> courses;
  const CourseCarousel({super.key, required this.courses});

  bool _isBase64(String? str) {
    if (str == null || str.isEmpty) return false;
    return !str.startsWith('http') && str.length > 50;
  }

  Widget _buildImage(String? thumbnailURL) {
    if (thumbnailURL == null || thumbnailURL.isEmpty) {
      return const Icon(Icons.image, size: 75);
    }

    if (_isBase64(thumbnailURL)) {
      try {
        final bytes = base64Decode(thumbnailURL);
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
      thumbnailURL,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 75),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 48, left: 2, right: 2),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.6,
          autoPlay: true,
          enlargeCenterPage: true,
          padEnds: false,
          height: 180,
        ),
        items: courses.map((course) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Card(
              margin: const EdgeInsets.only(bottom: 10),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(child: _buildImage(course.thumbnailURL)),
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
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
