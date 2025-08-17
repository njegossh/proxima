// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'controller.dart';

class AppointmentCreationMainSheet extends StatefulWidget {
  final Course course;
  const AppointmentCreationMainSheet({super.key, required this.course});

  @override
  State<AppointmentCreationMainSheet> createState() => _AppointmentCreationMainSheetState();
}

class _AppointmentCreationMainSheetState extends State<AppointmentCreationMainSheet> {
  late AppointmentCreateController controller;

  @override
  void initState() {
    controller = AppointmentCreateController(
      course: widget.course,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child){
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kurs'),
                  Text(widget.course.name),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pocetak'),
                  ElevatedButton(
                    child: Text(controller.from.prettified),
                    onPressed: () => controller.pickFrom(context),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kraj'),
                  ElevatedButton(
                    child: Text(controller.to.prettified),
                    onPressed: () => controller.pickTo(context),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  await controller.confirm();
                  Navigator.of(context).pop();
                }, 
                child: Text('Posalji zahtev'),
              ),
            ],
          ),
        );
      },
    );
  }
}
