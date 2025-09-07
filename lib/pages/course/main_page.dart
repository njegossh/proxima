import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/pages/appointment_creation/main_sheet.dart';
import 'package:proxima/pages/course/components/course_display_image.dart';
import 'package:proxima/pages/course/components/reviews_preview.dart';
import 'package:proxima/pages/course/components/user_info.dart';
import 'package:proxima/pages/course/components/video_showcase.dart';
import 'package:proxima/pages/course/controller.dart';
import 'components/tags_chips.dart';

class CourseMainPage extends StatefulWidget {
  final Course course;
  const CourseMainPage({super.key, required this.course});

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
          appBar: AppBar(elevation: 0),
          floatingActionButton: FloatingActionButton.extended(
              label: Text('Zahtev za novi termin'),
              icon: Icon(Icons.event),
              onPressed: () => showModalBottomSheet(
                context: context, 
                builder: (_) => AppointmentCreationMainSheet(course: widget.course),
              ),
            ),
          body: ListView(
            children: [
              SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  child: Text(
                    course.name,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              SizedBox(height: 24),
              CourseDisplayImage(imageString: course.thumbnailString),
              SizedBox(height: 24),
              Center(child: TagsChips(tags: course.tags)),
              SizedBox(height: 24),
              Builder(
                builder: (context) {
                  if (course.user == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return UserInfo(user: course.user!);
                  }
                },
              ),
              course.description != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 32,
                      ),
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
              Builder(
                builder: (context) {
                  if (controller.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ReviewsPreview(reviews: controller.reviewList, course: controller.course,);
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
                            child: Videoshowcase(videoURL: course.videoURL!),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
