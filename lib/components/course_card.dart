import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/pages/course/main_page.dart';

class CourseCard extends StatelessWidget{
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return CourseMainPage(course: course);
          }));
        },
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: (course.thumbnailURL == null || course.thumbnailURL!.isEmpty)
                ? Icon(Icons.image, size: 75)
                : Image.network(
                  course.thumbnailURL!,
                  fit: BoxFit.cover,
                ),
              ),
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
                    shadows: [
                      const Shadow(
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
      ),
    );
  }
}
