import 'package:flutter/material.dart';
import 'package:proxima/pages/course/components/course_display_image.dart';
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
          appBar: AppBar(elevation: 0, title: Text("Kreiraj novi kurs:")),
          body: ListView(
            children: [
              SizedBox(height: 32),
              InputForm(controller: controller),
            ],
          ),
        );
      },
    );
  }
}
