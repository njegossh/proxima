import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/components/course_card.dart';

class CourseCarousel extends StatelessWidget {
  final List<Course> courses;
  const CourseCarousel({super.key, required this.courses});

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
          return CourseCard(course: course);
        }).toList(),
      ),
    );
  }
}
