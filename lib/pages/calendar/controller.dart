import 'package:flutter/material.dart';
import 'dart:math';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sync;
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/classes/models/appointment.dart';


class CalendarMainController extends sync.CalendarDataSource<Appointment> {
  final User user;
  Map<String, Color> classColors = {};

  CalendarMainController({required this.user}){
    init();
  }

  Future<void> init() async {
    appointments = user.appointments;
    await user.reloadAppointments();
    for(final app in user.appointments!){
      app.reload();
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
    return this[index].name;
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
    return (user.appointments ?? [])[index];
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
