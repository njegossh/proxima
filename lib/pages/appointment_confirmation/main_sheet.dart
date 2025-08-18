// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proxima/classes/models/appointment.dart';
import 'package:proxima/main.dart';

import 'controller.dart';

class AppointmentConfirmationMainSheet extends StatefulWidget {
  final Appointment appointment;
  const AppointmentConfirmationMainSheet({super.key, required this.appointment});

  @override
  State<AppointmentConfirmationMainSheet> createState() => _AppointmentConfirmationMainSheetState();
}

class _AppointmentConfirmationMainSheetState extends State<AppointmentConfirmationMainSheet> {

    late AppointmentConfirmationController controller;

  @override
    void initState() {
      controller = AppointmentConfirmationController(widget.appointment);
      super.initState();
    }

    @override
  Widget build(BuildContext context) {
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
          ListTile(
            title: Text('Confirm'.tr),
            trailing: Checkbox(
              value: false, 
              onChanged: (val) async {
                await controller.confirm();
                Navigator.of(context).pop();
              },
            ),
          ),
          ListTile(
            title: Text('Decline'.tr),
            trailing: Checkbox(
              value: false, 
              onChanged: (val) async {
                await controller.decline();
                Navigator.of(context).pop();
              },
            ),
          ), //TODO MARKO Nece da radi confirmation kad udjem na calendar pise confirm for... ali mi ulazi na kurs ne izbacuje mi sheet za confirm
        ],
      ),
    );
  }
}
