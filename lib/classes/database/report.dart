import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/models/report.dart';
import 'database.dart';

extension ReportDatabase on Database {
  CollectionReference get reports => firestore.collection('reports');

  Future<void> sendReport(Report report) async {
    final snap = await reports.add(report.toJson());
    report.id = snap.id;
  }
}