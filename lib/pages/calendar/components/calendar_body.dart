// ignore_for_file: use_build_context_synchronously
import 'package:kalender/kalender.dart';
import 'package:proxima/classes/models/appointment.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/appointment_confirmation/main_sheet.dart';
import 'package:proxima/pages/course/main_page.dart';
import 'package:flutter/material.dart';
import '../controller.dart';

class CalendarMainBody extends StatefulWidget {
  final User user;
  const CalendarMainBody({super.key, required this.user});

  @override
  State<CalendarMainBody> createState() => _CalendarMainBodyState();
}

class _CalendarMainBodyState extends State<CalendarMainBody> {
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
      listenable: controller,
      builder: (context, child) {
        if( controller.user.appointments == null) {
          return Center( 
            child: CircularProgressIndicator()
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
            spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: controller.month,
                  builder: (context, value, child) {
                    return Text(value, style: TextStyle(fontSize: 20));
                  }
                ),
                Expanded(
                  child: CalendarView<Appointment>(
                    calendarController: controller.calendar,
                    eventsController: controller.events,
                    //PROMENITE ISPOD DA VIDITE ALTERNATIVNI PRIKAZ
                    //viewConfiguration: ScheduleViewConfiguration.continuous(),
                    viewConfiguration: MultiDayViewConfiguration.week(),
                    callbacks: CalendarCallbacks( 
                      onPageChanged: controller.onPageChanged,
                      onEventTapped: (event, renderBox) async {
                        final app = event.data!;
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
                    ),
                    header: CalendarHeader<Appointment>(),
                    body: CalendarBody<Appointment>(
                      multiDayBodyConfiguration: MultiDayBodyConfiguration( 
                        scrollPhysics: BouncingScrollPhysics(),
                      ),
                      interaction: ValueNotifier(CalendarInteraction(
                        allowResizing: false,
                        allowRescheduling: false,
                        allowEventCreation: false,
                      )),
                      multiDayTileComponents: TileComponents(
                        tileBuilder: (event, time) {
                          if (event.data == null) return Container();
                          final app = event.data!;
                          return Container(
                            decoration: BoxDecoration(
                              color: controller.getColor(app),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: Text(
                                controller.getSubject(app),
                                style: TextStyle(
                                  color: controller.getTitleColor(app),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      scheduleTileComponents: ScheduleTileComponents(
                        tileBuilder: (event, time) {
                          if (event.data == null) return Container();
                          final app = event.data!;
                          return Container(
                            height: 75,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: controller.getColor(app),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Align(
                            alignment: Alignment.centerLeft,
                              child: Text(
                                controller.getScheduleSubject(app),
                                style: TextStyle(
                                  color: controller.getTitleColor(app),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }
    );
  }
}
