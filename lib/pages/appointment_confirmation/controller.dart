
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/appointment.dart';
import 'package:proxima/main.dart';

class AppointmentConfirmationController {
  final Appointment appointment;

  AppointmentConfirmationController(this.appointment);

  Future<void> confirm() async {
    appointment.confirmed = true;
    await Database().updateAppointment(appointment);
    currentUser.reload();
  }

  Future<void> decline() async {
    await Database().deleteAppointment(appointment);
    currentUser.reload();
  }
}
