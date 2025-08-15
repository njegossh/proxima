import 'package:flutter/material.dart';
import 'package:proxima/pages/account/components/edit_button.dart';
import 'package:proxima/pages/account/components/edit_sheet.dart';
import 'package:proxima/pages/account/components/location.dart';
import 'package:proxima/pages/account/controller.dart';
import 'package:proxima/pages/user/components/course_carousel.dart';
import 'components/avatar.dart';
import 'components/interest_chips.dart';

class AccountMainPage extends StatefulWidget {
  final AccountController controller;
  const AccountMainPage({super.key, required this.controller});

  @override
  State<AccountMainPage> createState() => _AccountMainPageState();
}

class _AccountMainPageState extends State<AccountMainPage> {
  late final AccountController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, index) {
        final account = controller.account;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: [
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
          body: ListView(
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
            ],
          ),
        );
      },
    );
  }
}
