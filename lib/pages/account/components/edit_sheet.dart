import 'package:flutter/material.dart';
import 'package:proxima/pages/account/controller.dart';

class EditAccountSheet extends StatelessWidget {
  final AccountController controller;
  const EditAccountSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 4),
                Icon(Icons.expand_more_outlined, size: 50),
                Text(
                  "Azuriranje profila",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
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
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
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
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
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
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
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
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
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
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
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
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
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
                    Navigator.pop(context);
                  },
                  child: Text('Ažuriraj'),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
