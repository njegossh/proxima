import 'package:proxima/pages/user/main_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sync;
import 'package:flutter/material.dart';
import '../../classes/models/appointment.dart';
import 'controller.dart';


class CalendarMainPage extends StatefulWidget {
  const CalendarMainPage({super.key});

  @override
  State<CalendarMainPage> createState() => _CalendarMainPageState();
}

class _CalendarMainPageState extends State<CalendarMainPage> {
  late CalendarMainController controller;

  @override
  void initState() {
    controller = CalendarMainController(user: mockUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return ListenableBuilder(
      listenable: user,
      builder: (context, child) {
        final appointments = user.appointments;
        if( appointments == null) return CircularProgressIndicator();
        return Scaffold( 
          appBar: AppBar( 
            title: Text( 
              "${user.name}'s appointments",
            ),
          ),
          body: sync.SfCalendar(
            view: sync.CalendarView.week,
            firstDayOfWeek: 1,
            dataSource: controller,
            onTap: (details){
              final app = details.appointments![0] as Appointment;
              //Odavde ode na stranicu classa
              print(app.name);
            },
          ),
        );
      }
    );
  }
}
