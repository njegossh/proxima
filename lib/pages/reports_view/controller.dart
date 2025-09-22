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

  StreamSubscription<List<User>>? _suspendedSub;

  ReportsController() {
    init();
    _subscribeToSuspendedUsers();
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

  Future<void> deleteReport(String reportId) async {
    await Database().deleteReport(reportId);
    notifyListeners();
  }

  void _subscribeToSuspendedUsers() {
    _loadingSuspended = true;
    notifyListeners();

    _suspendedSub = Database().suspendedUsersStream().listen((users) {
      _suspendedUsers
        ..clear()
        ..addAll(users);

      _loadingSuspended = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _suspendedSub?.cancel();
    super.dispose();
  }
}

