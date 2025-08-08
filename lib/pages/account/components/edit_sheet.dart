import 'package:flutter/material.dart';
import 'package:proxima/pages/account/controller.dart';

class EditAccountSheet extends StatefulWidget {
  final AccountController controller;
  const EditAccountSheet({super.key, required this.controller});

  @override
  State<EditAccountSheet> createState() => _EditAccountSheetState();
}

class _EditAccountSheetState extends State<EditAccountSheet> {
  late TextEditingController firstNameCtrl;
  late TextEditingController lastNameCtrl;
  late TextEditingController avatarUrlCtrl;
  late TextEditingController locXCtrl;
  late TextEditingController locYCtrl;
  late TextEditingController locationDescCtrl;
  late TextEditingController interestsCtrl;
  late TextEditingController descriptionCtrl;

  @override
  void initState() {
    final acc = widget.controller.account!;
    firstNameCtrl = TextEditingController(text: acc.name);
    lastNameCtrl = TextEditingController(text: acc.surname);
    avatarUrlCtrl = TextEditingController(text: acc.avatarURL ?? '');
    locXCtrl = TextEditingController(text: acc.locationX.toString());
    locYCtrl = TextEditingController(text: acc.locationY.toString());
    descriptionCtrl = TextEditingController(text: acc.description);
    locationDescCtrl = TextEditingController(
      text: acc.locationDesc?.join(', ') ?? '',
    );
    interestsCtrl = TextEditingController(text: acc.interests.join(', '));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 24,),
            Text("Azuriranje profila", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 24,),
            TextField(
              maxLines: 1,
              controller: firstNameCtrl,
              decoration: InputDecoration(labelText: 'Ime', fillColor: Theme.of(context).colorScheme.secondary),
            ),
            TextField(
              maxLines: 1,
              controller: lastNameCtrl,
              decoration: InputDecoration(labelText: 'Prezime'),
            ),
            TextField(
              maxLines: 4,
              controller: descriptionCtrl,
              decoration: InputDecoration(labelText: 'Opis'),
            ),
            TextField(
              maxLines: 2,
              controller: avatarUrlCtrl,
              decoration: InputDecoration(labelText: 'Profilna slika'),
            ),
            TextField(
              maxLines: 1,
              controller: locXCtrl,
              decoration: InputDecoration(labelText: 'Lokacija X'),
            ),
            TextField(
              maxLines: 1,
              controller: locYCtrl,
              decoration: InputDecoration(labelText: 'Lokacija Y'), //Trenutno se pozicija dodaje kao koordinate, bice promenjeno
            ),
            TextField(
              maxLines: 2,
              controller: locationDescCtrl,
              decoration: InputDecoration(
                labelText: 'Lokacija (format: \'mesto, grad, drzava...\')',
              ),
            ),
            TextField(
              maxLines: 2,
              controller: interestsCtrl,
              decoration: InputDecoration(
                labelText: 'Interesovanja (format: \'prvo, drugo, trece...\')',
              ),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.controller.updateAccount(
                  firstName: firstNameCtrl.text,
                  lastName: lastNameCtrl.text,
                  avatarURL: avatarUrlCtrl.text.isEmpty
                      ? null
                      : avatarUrlCtrl.text,
                  locX: locXCtrl.text,
                  locY: locYCtrl.text,
                  description: descriptionCtrl.text,
                  locationDesc: locationDescCtrl.text.isEmpty
                      ? null
                      : locationDescCtrl.text
                            .split(',')
                            .map((e) => e.trim())
                            .toList(),
                  interests: interestsCtrl.text
                      .split(',')
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList(),
                );
                Navigator.pop(context);
              },
              child: Text('Ažuriraj'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
