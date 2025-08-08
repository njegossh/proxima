import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/course.dart';
import 'package:proxima/classes/mock/review.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/pages/course/components/course_display_image.dart';
import 'package:proxima/pages/course/components/reviews_preview.dart';
import 'package:proxima/pages/course/components/user_info.dart';
import 'package:proxima/pages/course/components/video_showcase.dart';
import 'components/tags_chips.dart';

class CourseMainPage extends StatefulWidget {
  final Course course = courseCPP;
  CourseMainPage({super.key});

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  Course get course => widget.course;

  @override
  void initState() {
    course.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: course,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(elevation: 0),
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
              Coursedisplayimage(displayImageURL: course.thumbnailURL),
              SizedBox(height: 24),
              Center(child: TagsChips(tags: course.tags)),
              SizedBox(height: 24),
              Builder(
                builder: (context) {
                  if (course.user == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return UserInfo(
                      username: course.user!.fullName,
                      avatarURL: course.user!.avatarURL,
                      location: course.user!.locationDesc != null
                          ? course.user!.locationDesc!.join(", ")
                          : "Nema podataka za lokaciju.",
                    );
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
              ReviewsPreview(reviews: reviews),
              SizedBox(height: 32),
              course.videoURL == null
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
