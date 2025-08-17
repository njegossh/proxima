import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'components/course_carousel.dart';
import 'components/interest_chips.dart';
import 'components/location.dart';
import 'components/avatar.dart';
import 'controller.dart';

class AccountMainPage extends StatefulWidget {
  const AccountMainPage({super.key});

  @override
  State<AccountMainPage> createState() => _AccountMainPageState();
}

class _AccountMainPageState extends State<AccountMainPage> {
  late final AccountController controller;

  @override
  void initState() {
    super.initState();
    controller = AccountController();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, index) {
        final account = controller.account;
        return ListView(
          padding: EdgeInsets.only(bottom: 64),
          children: [
            SizedBox(height: 24),
            Center(child: AvatarWidget(avatarURL: account.avatarURL)),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(right: 16, left: 16),
                child: Text(
                  account.fullName,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SizedBox(height: 12),
            LocationInfo(account: account),
            Center(child: InterestChips(listOfInterests: account.interests)),
          (account.description != null && account.description!.isNotEmpty)
            ? Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      account.description ?? 'a',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            )
            : SizedBox.shrink(),
            CourseCarousel(courses: account.courses ?? []),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: controller.logout, 
                child: Text('Logout'.tr),
              ),
            )
          ],
        );
      },
    );
  }
}
