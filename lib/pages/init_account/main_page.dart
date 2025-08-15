import 'package:flutter/material.dart';
import 'package:proxima/pages/account/components/edit_button.dart';
import 'package:proxima/pages/account/components/edit_sheet.dart';
import 'package:proxima/pages/account/components/location.dart';
import 'package:proxima/pages/account/controller.dart';
import 'package:proxima/pages/user/components/course_carousel.dart';
import 'components/avatar.dart';
import 'components/interest_chips.dart';

class InitAccountMainPage extends StatefulWidget {
  const InitAccountMainPage({super.key});

  @override
  State<InitAccountMainPage> createState() => _InitAccountMainPageState();
}

class _InitAccountMainPageState extends State<InitAccountMainPage> {
  final controller = AccountController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, index) {
        final account = controller.account;
        return Scaffold(
          appBar: AppBar(elevation: 0, title: Text("Podesite profil")),
          body: ListView(
            children: [
              SizedBox(height: 24),
              Center(child: AvatarWidget(avatarURL: account.avatarURL)),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: SingleChildScrollView(
                  child: Card(
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 24),
                          TextField(
                            controller: controller.firstNameCtrl,
                            decoration: InputDecoration(
                              labelText: 'Ime',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: controller.lastNameCtrl,
                            decoration: InputDecoration(
                              labelText: 'Prezime',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: controller.descriptionCtrl,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Opis',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: controller.avatarUrlCtrl,
                            decoration: InputDecoration(
                              labelText: 'Profilna slika',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: controller.locationDescCtrl,
                            decoration: InputDecoration(
                              labelText: 'Grad i drzava',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: controller.interestsCtrl,
                            decoration: InputDecoration(
                              labelText: 'Interesovanja',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          CheckboxListTile(
                            title: Row(
                              children: [
                                Icon(
                                  controller.trackLocation
                                      ? Icons.location_on
                                      : Icons.location_off,
                                ),
                                SizedBox(width: 6),
                                Text("Podesi lokaciju?"),
                              ],
                            ),
                            value: controller.trackLocation,
                            onChanged: controller.trackLocationChange,
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              controller.updateAccount();
                            },
                            child: Row(

                              children: [
                                Text('Nastavi'),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded, color: Theme.of(context).colorScheme.surface,)
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
