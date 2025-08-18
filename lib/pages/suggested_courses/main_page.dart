import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/search/components/course_card.dart';
import 'controller.dart';

class SuggestedCoursesMainPage extends StatefulWidget {
  const SuggestedCoursesMainPage({super.key});

  @override
  State<SuggestedCoursesMainPage> createState() =>
      _SuggestedCoursesMainPageState();
}

class _SuggestedCoursesMainPageState extends State<SuggestedCoursesMainPage> {
  final controller = SuggestedCoursesController();

  @override
  void initState() {
    controller.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final courses = controller.suggestedCourses;
        if (courses == null) {
          return Center(child: CircularProgressIndicator());
        } else if (courses.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.not_interested,
                  size: 50,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                SizedBox(height: 16,),
                Text(
                  "No courses for given radius!".tr,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }
        {
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return CourseCard(course: course);
            },
          );
        }
      },
    );
  }
}
