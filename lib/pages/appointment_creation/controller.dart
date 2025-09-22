// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/appointment.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';

class AppointmentCreateController extends ChangeNotifier {
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  Course course;

  AppointmentCreateController({required this.course});

  void setCourse(Course? course) {
    this.course = course!;
    notifyListeners();
  }

  Future<void> pickFrom(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: from,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(from),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    from = date!.copyWith(hour: time?.hour, minute: time?.minute);
    notifyListeners();
  }

  Future<void> pickTo(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: to,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(to),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    to = date!.copyWith(hour: time?.hour, minute: time?.minute);
    notifyListeners();
  }

  Future<void> confirm() async {
    final reversed = from.compareTo(to) == 1;
    await Database().createAppointment(
      Appointment(
        from: reversed ? to : from,
        to: reversed ? from : to,
        courseID: course.id!,
        confirmed: false,
        studentID: currentUser.id,
      ),
    );
    await currentUser.reload();
  }
}

extension PrettyDate on DateTime {
  String get prettified => '$year-$month-$day $hour:$minute';
}
