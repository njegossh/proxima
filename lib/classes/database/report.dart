import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/models/report.dart';
import 'database.dart';

extension ReportDatabase on Database {
  CollectionReference get reports => firestore.collection('reports');
  CollectionReference get users => firestore.collection('users');

  Future<void> sendReport(Report report) async {
    final snap = await reports.add(report.toJson());
    report.id = snap.id;
  }

  Future<List<Report>> fetchAllReports() async {
    final snap = await reports.orderBy('date', descending: true).get();
    return snap.docs.map((e) {
      return Report.fromJson(e.data() as Map, e.id);
    }).toList();
  }

  Future<void> deleteReport(String reportId) async {
    if (reportId.isEmpty) return;
    await reports.doc(reportId).delete();
  }
}
