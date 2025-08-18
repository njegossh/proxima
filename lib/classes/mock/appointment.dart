import 'package:proxima/classes/models/appointment.dart';

final appointments = [appointment1, appointment2, appointment3, appointment4];

final appointment1 = Appointment(
  from: DateTime(2025, 6, 27),
  to: DateTime(2025, 7, 26, 12),
  courseID: 'ccc',
  confirmed: false,
  studentID: "",
);
final appointment2 = Appointment(
  from: DateTime(2025, 7, 27, 7),
  to: DateTime(2025, 7, 27, 8),
  courseID: 'aaa',
  confirmed: false,
  studentID: "",
);
final appointment3 = Appointment(
  from: DateTime(2025, 7, 27, 8),
  to: DateTime(2025, 7, 27, 9),
  courseID: 'bbb',
  confirmed: false,
  studentID: "",
);
final appointment4 = Appointment(
  from: DateTime(2025, 7, 27, 12),
  to: DateTime(2025, 7, 27, 14, 30),
  courseID: 'aaa',
  confirmed: false,
  studentID: "",
);
