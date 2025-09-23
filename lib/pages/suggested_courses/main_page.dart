import 'package:flutter/material.dart';
import 'package:proxima/components/course_display_card.dart';
import 'package:proxima/components/frosted_glass.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/map/main_page.dart';
import 'package:proxima/pages/suggested_courses/components/appointment_card.dart';
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
    super.initState();
    controller.refresh();
    controller.fetchNextAppointment();
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
            padding: EdgeInsets.only(bottom: 64),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: FrostedGlassCard(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 24),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${"Hello".tr}, ${currentUser.name}!",
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
                                    .tr, //Ovde vrati dan pa ga prevede na drugi jezik
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.waving_hand_rounded,
                        size: 35,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Spacer(),
                      if (currentUser.superuser) ...[
                        Icon(Icons.admin_panel_settings_rounded, size: 25, color: Theme.of(context).colorScheme.tertiary,),
                        Text(
                          "Admin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        SizedBox(width: 24,)
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 230,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      currentUser.superuser ? "assets/images/illustrationAdmin.png" : "assets/images/illustration.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 250,
                        child: FrostedGlassCard(
                          child: Center(
                            child: controller.nextAppointment == null ? Column(
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
                                  margin: const EdgeInsets.all(2),
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
                              ],
                            ) : AppointmentCard(appointment: controller.nextAppointment!),
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
                                    margin: const EdgeInsets.all(2),
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      controller.getRandomTip().tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MapMainPage(),
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
                                    margin: const EdgeInsets.all(2),
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 2,
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

              const SizedBox(height: 16),

              Container(
                margin: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.near_me_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Courses in your neighbourhood:".tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              if (courses == null)
                const Center(child: CircularProgressIndicator())
              else if (courses.isEmpty)
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      height: 230,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/illustrationNoResult.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 64),
                  ],
                )
              else
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 12,
                    right: 12,
                    bottom: 24,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.tertiary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: courses
                        .map((course) => CourseCard(course: course))
                        .toList(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
