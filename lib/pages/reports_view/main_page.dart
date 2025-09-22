import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/reports_view/components/report_card.dart';
import 'package:proxima/pages/reports_view/controller.dart';
import 'package:proxima/pages/user/main_page.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/classes/database/database.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView>
    with SingleTickerProviderStateMixin {
  late ReportsController controller;
  List<User> suspendedUsers = [];
  bool loadingSuspended = true;

  @override
  void initState() {
    super.initState();
    controller = ReportsController();
    _loadSuspendedUsers();
  }

  Future<void> _loadSuspendedUsers() async {
    try {
      final snap = await Database().users
          .where('suspended', isEqualTo: true)
          .get();

      setState(() {
        suspendedUsers = snap.docs
            .map((doc) => User.fromJson(doc.data() as Map, doc.id))
            .toList();
        loadingSuspended = false;
      });
    } catch (e) {
      print('Error fetching suspended users: $e');
      setState(() => loadingSuspended = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reports'.tr),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Reports'),
              Tab(text: 'Suspended Users'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListenableBuilder(
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
                        builder: (context) => UserMainPage(
                          user: controller.allReports[index].userTo,
                        ),
                      ),
                    ),
                    child: ReportCard(
                      report: controller.allReports[index].report,
                      fromUser: controller.allReports[index].userFrom,
                      toUser: controller.allReports[index].userTo,
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                );
              },
            ),

            ListenableBuilder(
              listenable: controller,
              builder: (context, child) {
                if (controller.loadingSuspended) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.suspendedUsers.isEmpty) {
                  return const Center(child: Text("No suspended users"));
                }

                return ListView.separated(
                  itemCount: controller.suspendedUsers.length,
                  itemBuilder: (context, index) {
                    final user = controller.suspendedUsers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: user.imageString != null //TODO RISTIC DODAJ SLIKE PLS
                            ? NetworkImage(user.imageString!)
                            : null,
                        child: user.imageString == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(user.fullName),
                      subtitle: const Text("Suspended"),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserMainPage(user: user),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
