// ignore_for_file: use_build_context_synchronously
import 'package:proxima/classes/models/appointment.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/appointment_confirmation/main_sheet.dart';
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
    void dispose() {
      controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller.calendarKey,
      builder: (context, child) {
        if( controller.user.appointments == null) {
          return Center( 
            child: CircularProgressIndicator()
          );
        } else {
          return sync.SfCalendar(
            key: controller.calendarKey.value,
            allowedViews: sync.CalendarView.values,
            view: sync.CalendarView.schedule,
            showNavigationArrow: true,
            showTodayButton: true,
            firstDayOfWeek: 1,
            dataSource: controller,
            onTap: (details) async {
              final app = details.appointments![0] as Appointment;
              final course = app.course ?? await app.reloadCourse();
              final appType = controller.appTypeFor(app);
              if( appType == AppointmentType.teachPending ) {
                showModalBottomSheet(context: context, builder: (_) {
                  return AppointmentConfirmationMainSheet(appointment: app);
                });
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CourseMainPage(course: course);
                }));
              }
            },
          );
        }
      }
    );
  }
}
