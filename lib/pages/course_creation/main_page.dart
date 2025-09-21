import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/course_creation/components/course_image_section.dart';
import 'package:proxima/pages/course_creation/controller.dart';
import 'components/form_card.dart';

class CourseCreationMainPage extends StatefulWidget {
  final Course? course;

  const CourseCreationMainPage({super.key, this.course});

  @override
  State<CourseCreationMainPage> createState() => _CourseCreationMainPageState();
}

class _CourseCreationMainPageState extends State<CourseCreationMainPage> {
  late final CourseCreationController controller;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = CourseCreationController(existingCourse: widget.course);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              widget.course == null ? "Create new course".tr : "Edit course".tr,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 1,
          ),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    CourseImageSection(
                      imageString: controller.thumbnailString,
                      onPickImage: controller.pickThumbnail,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: FormCard(controller: controller),
              ),
            ],
          ),
        );
      },
    );
  }
}
