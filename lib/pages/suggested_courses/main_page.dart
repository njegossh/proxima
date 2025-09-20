import 'package:flutter/material.dart';
import 'package:proxima/components/frosted_glass.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/map/main_page.dart';
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
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(right: 16, left: 16),
                child: FrostedGlassCard(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 24),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${currentUser.name}!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Today is ".tr +
                                controller
                                    .getWeekdayName(DateTime.now().weekday)
                                    .tr,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.waving_hand_rounded,
                        size: 35,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 230,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/illustration.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 250,
                        child: FrostedGlassCard(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.assignment,
                                  size: 50,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                                Text(
                                  "Upcoming class!".tr,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Container(
                                  margin: EdgeInsets.all(2),
                                  width: 150,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                //TODO Napraviti ovde upcoming class ili staviti da nema nista ako nema
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
                            height: 120,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.tips_and_updates,
                                    size: 30,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                  ),
                                  Text("Bonus tip!".tr),
                                  Container(
                                    margin: EdgeInsets.all(2),
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.tertiary,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 2,
                                    ),
                                    child: Text(
                                      "You can create your own courses!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MapMainPage(),
                              ),
                            ),
                            child: Container(
                              width: 300,
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.tertiary,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.map_rounded,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    size: 30,
                                  ),
                                  Text(
                                    "Search the map!".tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(2),
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 2,
                                    ),
                                    child: Text(
                                      "Search the courses on the map.".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  "Courses in your neibourhood:".tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 12),
              if (courses == null)
                Center(child: CircularProgressIndicator())
              else if (courses.isEmpty)
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      height: 230,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/illustrationNoResult.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "It seems there is nothing around!".tr,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "No courses that match your interests in the given radius"
                          .tr,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 64),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
