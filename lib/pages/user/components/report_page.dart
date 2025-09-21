import 'package:flutter/material.dart';
import 'package:proxima/classes/models/report.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/init_account/components/custom_text_field.dart';
import 'package:proxima/pages/user/controller.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key, required this.userController});

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    final reportTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Report".tr)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              height: 230,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/illustrationReport.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomTextField(
              controller: reportTextController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              label: "Report text".tr,
              icon: Icons.report_outlined,
              hint: "Enter the reason for reporting...".tr,
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                final text = reportTextController.text.trim();
                if (text.isEmpty) {
                  // optional: show a warning if the report text is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter a report description.".tr),
                    ),
                  );
                  return;
                }

                try {
                  await userController.sendReport(
                    Report(
                      fromUserID: currentUser.id,
                      toUserID: userController.user.id,
                      desc: text,
                      date: DateTime.now(),
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Report sent successfully!".tr)),
                  );

                  Future.delayed(Duration(milliseconds: 500), () {
                    Navigator.of(context).pop();
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Failed to send report: $e",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send),
                  SizedBox(width: 8),
                  Text("Send a report".tr),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
