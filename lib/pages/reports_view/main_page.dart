import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/reports_view/components/report_card.dart';
import 'package:proxima/pages/reports_view/controller.dart';
import 'package:proxima/pages/user/main_page.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  late ReportsController controller;

  @override
  void initState() {
    controller = ReportsController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reports'.tr)),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.allReports.isEmpty) {
            return const Center(child: Text("No reports found"));
          }

          return ListView.separated(
            itemCount: controller.allReports.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      UserMainPage(user: controller.allReports[index].userTo),
                ),
              ),
              child: ReportCard(
                report: controller.allReports[index].report,
                fromUser: controller.allReports[index].userFrom,
                toUser: controller.allReports[index].userTo,
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 24),
          );
        },
      ),
    );
  }
}
