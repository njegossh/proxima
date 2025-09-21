import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/appointment_creation/main_sheet.dart';
import 'package:proxima/pages/course/components/course_display_image.dart';
import 'package:proxima/pages/user/components/report_page.dart';
import 'package:proxima/pages/course/components/reviews_preview.dart';
import 'package:proxima/pages/course/components/user_info.dart';
import 'package:proxima/pages/course/components/video_showcase.dart';
import 'package:proxima/pages/course/controller.dart';
import 'package:proxima/pages/course_creation/main_page.dart';
import 'components/tags_chips.dart';

class CourseMainPage extends StatefulWidget {
  final Course course;
  final VoidCallback? onChanged;
  const CourseMainPage({super.key, required this.course, this.onChanged});

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  Course get course => controller.course;
  late CourseMainController controller;

  @override
  void initState() {
    controller = CourseMainController(course: widget.course);
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(elevation: 0, title: Text(controller.course.name)),
          floatingActionButton: (controller.course.user?.id == currentUser.id)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton.extended(
                      label: Text("Edit".tr),
                      heroTag: 'edit_fab',
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CourseCreationMainPage(
                              course: controller.course,
                            ),
                          ),
                        ).then((_) async {
                          await controller.course.reload();
                          controller.refresh();
                          widget.onChanged?.call();
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    FloatingActionButton.extended(
                      label: Text("Delete".tr),
                      heroTag: 'delete_fab',
                      icon: Icon(Icons.delete),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      onPressed: () async {
                        final deleted = await controller.deleteCourse(context);
                        if (deleted) {
                          widget.onChanged?.call();
                          scheduleMicrotask(() {
                            Navigator.pop(context);
                          });
                        }
                      },
                    ),
                  ],
                )
              : FloatingActionButton.extended(
                  label: Text("Book".tr),
                  icon: Icon(Icons.event),
                  heroTag: 'request_fab',
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) =>
                        AppointmentCreationMainSheet(course: widget.course),
                  ),
                ),
          body: ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 350,
                    margin: EdgeInsets.only(left: 4, right: 4),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.tertiary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(width: 420, height: 300, child: Card()),
                    ),
                  ),

                  Positioned(
                    top: 37,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CourseDisplayImage(
                        imageString: course.thumbnailString,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 280,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        course.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 25,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(width: 8),
                    Text("Instructor".tr, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Builder(
                builder: (context) {
                  if (course.user == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return UserInfo(user: course.user!);
                  }
                },
              ),
              SizedBox(height: 32),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.interests_rounded,
                      size: 25,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(width: 8),
                    Text("Tags".tr, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Center(child: TagsChips(tags: course.tags)),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.description,
                      size: 25,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(width: 8),
                    Text("Description".tr, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(height: 12),
              course.description != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.all(0),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              course.description!,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 32),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.reviews_rounded,
                      size: 25,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(width: 8),
                    Text("Reviews".tr, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Builder(
                builder: (context) {
                  if (controller.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ReviewsPreview(
                      reviews: controller.reviewList,
                      course: controller.course,
                    );
                  }
                },
              ),
              SizedBox(height: 32),
              (course.videoURL == null || course.videoURL == '')
                  ? SizedBox.shrink()
                  : Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      width: double.infinity,
                      child: Card(
                        margin: EdgeInsets.all(0),
                        color: Colors.white,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(20.0),
                              child: Videoshowcase(videoURL: course.videoURL!),
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }
}
