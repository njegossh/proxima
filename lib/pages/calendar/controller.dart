import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:proxima/main.dart';
import 'dart:math';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/classes/models/appointment.dart';

enum AppointmentType { teachConfirmed, teachPending, attendConfirmed, attendPending }

class CalendarMainController extends ChangeNotifier {

  final events = DefaultEventsController<Appointment>();
  final calendar = CalendarController<Appointment>();

  final User user;
  Map<String, Color> classColors = {};
  final calendarKey = ValueNotifier(UniqueKey());

  final month = ValueNotifier(' ');

  CalendarMainController({required this.user}){
    init();
  }

  Future<void> init() async {
    await user.reload();
    for (final app in user.calendarAppointments) {
      await app.reload();
    }
    refresh();
    user.addListener(refresh);
  }

  void onPageChanged(DateTimeRange range) {
    final index = range.dominantMonthDate.month;
    month.value = [
      ' ',
      'January',
      'Februrary',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November'
      'December',
    ][index].tr;
  }

  void refresh() {
    events.clearEvents();
    events.addEvents(user.calendarAppointments.map((app) {
      return CalendarEvent(
        dateTimeRange: DateTimeRange(start: app.from, end: app.to),
        data: app,
      );
    }).toList());
    notifyListeners();
  }

  AppointmentType appTypeFor(Appointment app) {
    if( user.appointments?.contains(app) ?? false ){
      if(app.confirmed) {
        return AppointmentType.teachConfirmed;
      } else {
        return AppointmentType.teachPending;
      }
    } else {
      if(app.confirmed) {
        return AppointmentType.attendConfirmed;
      } else {
        return AppointmentType.attendPending;
      }
    }
  }

  String getScheduleSubject(Appointment app) {
    final timeFrom = '${app.from.hour}:${app.from.minute}';
    final timeTo = '${app.to.hour}:${app.to.minute}';
    return '$timeFrom-$timeTo\n${getSubject(app)}';
  }

  String getSubject(Appointment? app) {
    if (app == null) return '?';
    switch(appTypeFor(app)){
      case AppointmentType.teachConfirmed:
        return app.name;
      case AppointmentType.teachPending: 
        return '${"Confirm for".tr} ${app.name}';
      case AppointmentType.attendConfirmed:
        return app.name;
      default: 
      return '${"Requested".tr} ${app.name}';
    }
  }

  Color getColor(Appointment? app) {
    if (app == null) return Colors.transparent;
    final courseID = app.courseID;
    
    if(classColors[courseID] == null){
      classColors.addAll({
        courseID : getRandomColor(),
      });
    }
    return classColors[courseID] ?? Colors.grey;
  }

  Appointment operator [](int index) {
    return user.calendarAppointments[index];
  }

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(200),
      random.nextInt(200),
      random.nextInt(200),
    );
  }

  Color getTitleColor(Appointment? app) {
    final back = getColor(app);
    return Color.fromARGB(
      (back.a * 255).toInt(),
      255 - back.r.toInt(),
      255 - back.g.toInt(),
      255 - back.b.toInt(),
    );
  }

  @override 
  void dispose() {
    events.removeListener(notifyListeners);
    calendar.removeListener(notifyListeners);
    super.dispose();
  }
}
