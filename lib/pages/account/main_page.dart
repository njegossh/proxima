import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/course.dart';
import 'package:proxima/pages/account/components/edit_button.dart';
import 'package:proxima/pages/account/components/edit_sheet.dart';
import 'package:proxima/pages/account/components/location.dart';
import 'package:proxima/pages/account/controller.dart';
import 'package:proxima/pages/user/components/course_carousel.dart';
import 'components/avatar.dart';
import 'components/interest_chips.dart';

class AccountMainPage extends StatefulWidget {
  const AccountMainPage({super.key});

  @override
  State<AccountMainPage> createState() => _AccountMainPageState();
}

class _AccountMainPageState extends State<AccountMainPage> {
  final controller = AccountController();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, index) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: controller.isLoading ? null : [
              EditButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return EditAccountSheet(controller: controller);
                    },
                  );
                },
              ),
            ],
          ),
          body: controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    SizedBox(height: 24),
                    Center(
                      child: AvatarWidget(
                        avatarURL: controller.account!.avatarURL,
                      ),
                    ),
                    SizedBox(height: 24),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16, left: 16),
                        child: Text(
                          controller.account!.fullName,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    LocationInfo(account: controller.account!),
                    Center(
                      child: InterestChips(
                        listOfInterests: controller.account!.interests,
                      ),
                    ),
                    (controller.account!.description != null &&
                            controller.account!.description!.isNotEmpty)
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    controller.account!.description ?? 'a',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    CourseCarousel(courses: courses),
                  ],
                ),
        );
      },
    );
  }
}
