import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/course_creation/main_page.dart';
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
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  margin: EdgeInsets.only(left: 8, right: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: currentUser.superuser
                          ? [
                              Theme.of(context).colorScheme.tertiary,
                              Theme.of(context).colorScheme.secondary,
                            ]
                          : [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).colorScheme.tertiary,
                            ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),

                if (currentUser.superuser)
                  Positioned(
                    top: 25,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.admin_panel_settings_rounded,
                            size: 25,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          Text(
                            "Admin",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                Positioned(
                  top: 75,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: AvatarWidget(imageString: account.imageString),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  account.fullName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SizedBox(height: 8),

            LocationInfo(account: account),
            SizedBox(height: 32),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.interests_outlined,
                    size: 25,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  SizedBox(width: 8),
                  Text("Interests".tr, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Center(child: InterestChips(listOfInterests: account.interests)),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 25,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  SizedBox(width: 8),
                  Text("About".tr, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            if (account.description != null && account.description!.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        account.description!,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),

            SizedBox(height: 16),

            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    size: 25,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  SizedBox(width: 8),
                  Text("My courses".tr, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),

            if (account.courses != null && account.courses!.isNotEmpty) ...[
              SizedBox(height: 16),

              CourseCarousel(
                courses: account.courses ?? [],
                onChanged: () async {
                  await controller.reloadAccount();
                },
              ),
            ],

            Container(
              margin: EdgeInsets.all(16),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CourseCreationMainPage();
                      },
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Icon(
                      Icons.add,
                      size: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(width: 8),
                    Text("Create course".tr),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
