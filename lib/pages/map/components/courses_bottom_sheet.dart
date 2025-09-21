import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/search/components/course_card.dart';

class CoursesBottomSheet extends StatelessWidget {
  const CoursesBottomSheet({super.key, required this.courses});

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .7,
      maxChildSize: 1,
      minChildSize: .2,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(16.0),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Available courses".tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: courses.length,
                  itemBuilder: (_, index) {
                    final course = courses[index];
                    return CourseCard(course: course);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
