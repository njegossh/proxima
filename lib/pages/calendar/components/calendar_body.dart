import 'package:proxima/classes/models/appointment.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/course/main_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sync;
import 'package:flutter/material.dart';
import '../controller.dart';


class CalendarBody extends StatefulWidget {
  final User user;
  const CalendarBody({super.key, required this.user});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  late CalendarMainController controller;

  @override
  void initState() {
    controller = CalendarMainController(user: widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return ListenableBuilder(
      listenable: user,
      builder: (context, child) {
        final appointments = user.appointments;
        if( appointments == null) {
          return Center( 
            child: CircularProgressIndicator()
          );
        } else {
          return sync.SfCalendar(
            view: sync.CalendarView.week,
            showNavigationArrow: true,
            firstDayOfWeek: 1,
            dataSource: controller,
            onTap: (details) async {
              final app = details.appointments![0] as Appointment;
              final course = app.course ?? await app.reloadCourse();
              // ignore: use_build_context_synchronously
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CourseMainPage(course: course);
              }));
            },
          );
        }
      }
    );
  }
}
