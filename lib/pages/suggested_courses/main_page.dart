import 'package:flutter/material.dart';
import 'package:proxima/components/frosted_glass.dart';
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
        return Container(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16, left: 16),
                  child: FrostedGlassCard(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 16),
                        Icon(
                          Icons.waving_hand_rounded,
                          size: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Hello, ' + currentUser.name + "!",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(16),
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/illustration.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 300,
                          child: FrostedGlassCard(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Content
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            FrostedGlassCard(
                              height: 140,
                              child: Center(child: Text('Card 2')),
                            ),
                            const SizedBox(height: 20),
                            FrostedGlassCard(
                              height: 140,
                              child: Center(child: Text('Card 3')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (courses == null)
                  Center(child: CircularProgressIndicator())
                else if (courses!.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 12),
                        Icon(
                          Icons.search_off,
                          size: 50,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
