import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/suspended/controller.dart';

class SuspendedMainPage extends StatelessWidget {
  SuspendedMainPage({super.key});

  final SuspendedController controller = SuspendedController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              height: 230,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/illustrationSuspended.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "You have been suspended!".tr,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              "It seems you have done something wrong!\n If you think this is a mistake, contact proxima administrators for help."
                  .tr,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                controller.logout();
              },
              child: Text("Return".tr),
            ),
          ],
        ),
      ),
    );
  }
}
