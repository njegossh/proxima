import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/database/report.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/reports_view/components/new_report_x.dart';

class ReportsController extends ChangeNotifier {
  List<NewReportX> get allReports => _allReports;
  List<User> get suspendedUsers => _suspendedUsers;

  final List<NewReportX> _allReports = [];
  final List<User> _suspendedUsers = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _loadingSuspended = false;
  bool get loadingSuspended => _loadingSuspended;

  ReportsController() {
    init();
    loadSuspendedUsers();
  }

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    final reports = await Database().fetchAllReports();
    _allReports.clear();

    for (final report in reports) {
      final userFrom = await Database().fetchUserFromID(report.fromUserID);
      final userTo = await Database().fetchUserFromID(report.toUserID);
      _allReports.add(
        NewReportX(report: report, userFrom: userFrom, userTo: userTo),
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadSuspendedUsers() async {
    _loadingSuspended = true;
    notifyListeners();

    final users = await Database().fetchSuspendedUsers();
    _suspendedUsers
      ..clear()
      ..addAll(users);

    _loadingSuspended = false;
    notifyListeners();
  }
}
