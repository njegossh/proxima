import 'package:flutter/material.dart';
import 'package:proxima/pages/course/main_page.dart';
import 'controller.dart';

class SuggestedCoursesMainPage extends StatefulWidget {
  const SuggestedCoursesMainPage({super.key});

  @override
  State<SuggestedCoursesMainPage> createState() => _SuggestedCoursesMainPageState();
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
      builder: (context, child){
        final courses = controller.suggestedCourses;
        if(courses == null){
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index){
              final course = courses[index];
              return ListTile( 
                title: Text(course.name),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CourseMainPage(course: course);
                  }));
                },
              );
            },
          );
        }
      },
    );
  }
}
