import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proxima/classes/models/appointment.dart';
import 'package:proxima/main.dart';

class AppointmentCard extends StatefulWidget {
  final Appointment appointment;
  const AppointmentCard({super.key, required this.appointment});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadCourse();
  }

  Future<void> _loadCourse() async {
    await widget.appointment.reloadCourse();
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final appt = widget.appointment;
    final dateFormat = DateFormat("EEE, d MMM • HH:mm");
    final timeRange =
        "${DateFormat.Hm().format(appt.from)} - ${DateFormat.Hm().format(appt.to)}";

    if (loading) {
      return const CircularProgressIndicator();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.assignment,
          size: 50,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Text("Upcoming class!".tr, style: TextStyle(fontSize: 16)),
        Container(
          margin: const EdgeInsets.all(2),
          width: 150,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          appt.course?.name ?? "?",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          dateFormat.format(appt.from),
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          timeRange,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        if (!appt.confirmed)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "Pending confirmation".tr,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
