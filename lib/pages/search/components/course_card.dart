import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/course/main_page.dart';

class CourseCard extends StatefulWidget {
  final Course course;
  final bool preloadImage;

  const CourseCard({
    super.key,
    required this.course,
    this.preloadImage = false,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Hero(
      tag: 'course_hero_${widget.course.id}',
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => _navigateToCourse(context),
          borderRadius: BorderRadius.circular(12),
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SimpleThumbnail(
                        course: widget.course,
                        loadImmediately: widget.preloadImage,
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: _CourseInfo(course: widget.course)),
                    ],
                  ),
                  if (widget.course.tags.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _CourseTagsWidget(tags: widget.course.tags),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToCourse(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseMainPage(course: widget.course),
      ),
    );
  }
}

// Simplified thumbnail widget
class _SimpleThumbnail extends StatefulWidget {
  final Course course;
  final bool loadImmediately;

  const _SimpleThumbnail({required this.course, this.loadImmediately = false});

  @override
  State<_SimpleThumbnail> createState() => _SimpleThumbnailState();
}

class _SimpleThumbnailState extends State<_SimpleThumbnail> {
  Uint8List? _imageBytes;
  bool _isLoading = false;
  bool _hasError = false;
  bool _shouldLoad = false;

  @override
  void initState() {
    super.initState();
    _shouldLoad = widget.loadImmediately;
    if (_shouldLoad) {
      _loadImage();
    }
  }

  @override
  void didUpdateWidget(_SimpleThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset state if course changed
    if (oldWidget.course.id != widget.course.id) {
      _imageBytes = null;
      _isLoading = false;
      _hasError = false;
      _shouldLoad = widget.loadImmediately;

      if (_shouldLoad) {
        _loadImage();
      }
    }
  }

  bool _isBase64(String? str) {
    if (str == null || str.isEmpty) return false;
    return !str.startsWith('http') && str.length > 50;
  }

  Future<void> _loadImage() async {
    if (_isLoading || _imageBytes != null) return;

    final thumbnailString = widget.course.thumbnailString;
    if (thumbnailString == null || thumbnailString.isEmpty) {
      setState(() => _hasError = true);
      return;
    }

    if (!_isBase64(thumbnailString))
      return;

    setState(() => _isLoading = true);

    try {
      await Future.delayed(Duration.zero);

      String base64String = thumbnailString;
      if (base64String.contains(',')) {
        base64String = base64String.split(',')[1];
      }

      final bytes = base64Decode(base64String);

      if (mounted) {
        setState(() {
          _imageBytes = bytes;
          _isLoading = false;
          _hasError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 80,
        height: 60,
        child: VisibilityDetector(
          key: Key('thumbnail_${widget.course.id}'),
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.1 && !_shouldLoad) {
              _shouldLoad = true;
              _loadImage();
            }
          },
          child: _buildImageWidget(),
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    final thumbnailString = widget.course.thumbnailString;

    if (thumbnailString == null || thumbnailString.isEmpty || _hasError) {
      return _buildPlaceholder(isError: _hasError);
    }

    if (_isBase64(thumbnailString)) {
      if (_isLoading) {
        return _buildPlaceholder(isLoading: true);
      }

      if (_imageBytes != null) {
        return Image.memory(
          _imageBytes!,
          fit: BoxFit.fitWidth,
          gaplessPlayback: true,
          errorBuilder: (_, __, ___) => _buildPlaceholder(isError: true),
        );
      }

      return _buildPlaceholder();
    }

    return Image.network(
      thumbnailString,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildPlaceholder(isLoading: true);
      },
      errorBuilder: (_, __, ___) => _buildPlaceholder(isError: true),
    );
  }

  Widget _buildPlaceholder({bool isLoading = false, bool isError = false}) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: isLoading
          ? const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : Icon(
              isError ? Icons.broken_image : Icons.school,
              size: 32,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
    );
  }
}

// Course info widget (same as before)
class _CourseInfo extends StatelessWidget {
  final Course course;

  const _CourseInfo({required this.course});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          course.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (course.description?.isNotEmpty == true) ...[
          const SizedBox(height: 4),
          Text(
            course.description!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.euro, size: 16, color: theme.colorScheme.primary),
            Text(
              "${course.pricePerHour.toStringAsFixed(0)} ",
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "per hour".tr,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Tags widget (same as before)
class _CourseTagsWidget extends StatelessWidget {
  final List<String> tags;
  static const int maxVisibleTags = 3;

  const _CourseTagsWidget({required this.tags});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleTags = tags.take(maxVisibleTags).toList();
    final hasMoreTags = tags.length > maxVisibleTags;

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: [
        ...visibleTags.map((tag) => _TagChip(tag: tag)),
        if (hasMoreTags)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+${tags.length - maxVisibleTags}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String tag;

  const _TagChip({required this.tag});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.primary, width: 0.5),
      ),
      child: Text(
        tag,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
    );
  }
}
