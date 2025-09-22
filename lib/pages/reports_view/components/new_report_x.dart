import 'package:proxima/classes/models/report.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class NewReportX {
  NewReportX({
    required this.report,
    required this.userFrom,
    required this.userTo
  });

  final String id = uuid.v4();
  final Report report;
  final User userFrom;
  final User userTo;
}