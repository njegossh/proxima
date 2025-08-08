import 'package:flutter/material.dart';
import 'package:proxima/pages/course_creation/components/input_form.dart';
import 'package:proxima/pages/course_creation/controller.dart';

class CourseCreationMainPage extends StatefulWidget {
  const CourseCreationMainPage({super.key});

  @override
  State<CourseCreationMainPage> createState() => _CourseCreationMainPageState();
}

class _CourseCreationMainPageState extends State<CourseCreationMainPage> {
  final controller = CourseCreationController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, index) {
        return Scaffold(
          appBar: AppBar(elevation: 0),
          body: ListView(
            children: [
              Center(child: Text("Number of courses: ${controller.courselen}")),
              SizedBox(height: 32),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_to_queue,
                      size: 65,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Kreiraj novi kurs:",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              InputForm(controller: controller),
            ],
          ),
        );
      },
    );
  }
}
