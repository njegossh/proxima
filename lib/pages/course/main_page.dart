import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/course.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/pages/course/components/course_display_image.dart';
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
          appBar: AppBar(
            elevation: 0,
          ),
          body: ListView(
            children: [
              Align(
                //NAZIV KURSA
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 48, bottom: 24),
                  child: Text(
                    course.name,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Coursedisplayimage(displayImageURL: course.thumbnailURL),
              SizedBox(height: 24),
              TagsChips(interests: course.tags),
              Builder(
                builder: (context) {
                  if (course.user == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Padding(
                      // INFORMACIJE INSTRUKTORA
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                        right: 4,
                        left: 4,
                      ),
                      child: UserInfo(
                        username: course.user!.fullName,
                        avatarURL: course.user!.avatarURL,
                      ),
                    );
                  }
                },
              ),
              Align(
                // DESKRIPCIJA KURSA : DODATI ATRIBUT ZA DESKRIPCIJU KURSA!
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 12,
                          bottom: 12,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          "Description to be addded!",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              course.videoURL == null
                  ? SizedBox.shrink()
                  : Padding(
                      // VIDEO O KURSU : TO BE ADDED!
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Card(
                          color: Colors.white,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Videoshowcase(videoURL: course.videoURL!),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
