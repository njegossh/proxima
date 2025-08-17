import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/models/appointment.dart';
import 'database.dart';

extension AppointmentsDB on Database {

  CollectionReference get appointments => firestore.collection('appointments');

  Future<Appointment> fetchAppointmentFromID(String appointmentID) async {
    final snap = await appointments.doc(appointmentID).get();
    return Appointment.fromJson(snap.data() as Map, appointmentID);
  }

  Future<void> createAppointment(Appointment appointment) async {
    final doc = await appointments.add(appointment.toJson());
    appointment.id = doc.id;
  }

  Future<void> updateAppointment(Appointment appointment) async {
    await appointments.doc(appointment.id).update(appointment.toJson());
  }

  Future<void> deleteAppointment(Appointment appointment) async {
    await appointments.doc(appointment.id).delete();
  }

  Future<List<Appointment>> fetchAppointmentsForCourseIDs(Iterable<String> courseIDs) async {
    if ( courseIDs.isEmpty ) return [];
    final query = appointments.where('courseID', whereIn: courseIDs);
    final result = await query.get();
    return result.docs.map((doc){
      return Appointment.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }

  Future<List<Appointment>> fetchAttendingForUserID(String userID) async {
    final query = appointments.where(
      'studentID', isEqualTo: userID,
    );
    final result = await query.get();
    return result.docs.map((doc){
      return Appointment.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }
}
