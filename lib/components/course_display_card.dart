import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/course/main_page.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  bool _isBase64(String? str) {
    if (str == null || str.isEmpty) return false;
    return !str.startsWith('http') && str.length > 50;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CourseMainPage(course: course);
            },
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildThumbnail(context),
                  const SizedBox(width: 12),
                  _buildCourseInfo(context),
                ],
              ),
              if (course.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildTags(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context) {
    Widget imageWidget;

    if (course.thumbnailString == null || course.thumbnailString!.isEmpty) {
      imageWidget = const Icon(Icons.school, size: 50);
    } else if (_isBase64(course.thumbnailString)) {
      try {
        final bytes = base64Decode(course.thumbnailString!);
        imageWidget = Image.memory(
          bytes,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 50),
        );
      } catch (_) {
        imageWidget = const Icon(Icons.broken_image, size: 50);
      }
    } else {
      imageWidget = Image.network(
        course.thumbnailString!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(width: 80, height: 60, child: imageWidget),
    );
  }

  Widget _buildCourseInfo(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.name,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            course.description ?? '',
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            '€${course.pricePerHour}' + "per hour".tr,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildTags(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: course.tags
          .map(
            (tag) => Chip(
              label: Text(
                tag,
                style: Theme.of(context).chipTheme.labelStyle!.copyWith(
                  fontSize: 11,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 2,
                vertical: 1,
              ),
            ),
          )
          .toList(),
    );
  }
}
