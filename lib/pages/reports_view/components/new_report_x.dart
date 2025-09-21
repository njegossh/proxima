import 'package:proxima/classes/models/report.dart';
import 'package:proxima/classes/models/user.dart';

class NewReportX {
  NewReportX({
    required this.report,
    required this.userFrom,
    required this.userTo
  });

  final Report report;
  final User userFrom;
  final User userTo;
}