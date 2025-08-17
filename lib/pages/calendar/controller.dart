import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'dart:math';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sync;
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/classes/models/appointment.dart';

enum AppointmentType { teachConfirmed, teachPending, attendConfirmed, attendPending }

class CalendarMainController extends sync.CalendarDataSource<Appointment> {
  final User user;
  Map<String, Color> classColors = {};
  Key calendarKey = UniqueKey();

  CalendarMainController({required this.user}){
    init();
  }

  Future<void> init() async {
    appointments = user.calendarAppointments;
    user.addListener((){
      appointments = user.calendarAppointments;
      calendarKey = UniqueKey();
    });
    await user.reload();
    for(final app in user.calendarAppointments){
      app.reload();
    }
    calendarKey = UniqueKey();
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

  @override
  getStartTime(int index) {
    return this[index].from;
  }

  @override
  getEndTime(int index) {
    return this[index].to;
  }

  @override
  getSubject(int index) {
    switch(appTypeFor(this[index])){
      case AppointmentType.teachConfirmed:
        return this[index].name;
      case AppointmentType.teachPending: 
        return '${'Confirm for'.tr} ${this[index].name}';
      case AppointmentType.attendConfirmed:
        return this[index].name;
      default: 
      return '${'Waiting for'.tr} ${this[index].name}';
    }
  }

  @override
  getColor(int index) {
    final app = this[index];
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

  @override
  isAllDay(int index) => false;

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(200),
      random.nextInt(200),
      random.nextInt(200),
    );
  }
}
