import 'package:flutter/material.dart';
import 'package:proxima/pages/init_account/controller.dart';
import 'components/avatar.dart';

class InitAccountMainPage extends StatefulWidget {
  const InitAccountMainPage({super.key});

  @override
  State<InitAccountMainPage> createState() => _InitAccountMainPageState();
}

class _InitAccountMainPageState extends State<InitAccountMainPage> {
  final controller = InitAccountController();

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
                          SizedBox(height: 32),
                          Text(
                            "Radijus pretrage kurseva: ${controller.range.toStringAsFixed(0)} km",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Slider(
                            min: 1,
                            max: 100,
                            divisions: 99,
                            value: controller.range,
                            label: "${controller.range.toStringAsFixed(0)} km",
                            onChanged: (value) {
                              controller.range = value;
                            },
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
                              //Navigator.pop(context); //TODO MARKO Ovde popuje i kad se inicijalizuje acc i kad se edituje, a treba samo kad se edituje
                            },
                            child: Row(
                              children: [
                                Text('Nastavi'),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
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
