import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/calendar/components/calendar_body.dart';

class CalendarMainPage extends StatelessWidget {
  final User user;
  const CalendarMainPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: CalendarMainBody(user: user),
    );
  }
}
