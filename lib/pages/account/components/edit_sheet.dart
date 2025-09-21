import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
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
                  "Profile editing".tr,
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
                    labelText: "Name".tr,
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
                    labelText: "Last name".tr,
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
                    labelText: "About".tr,
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
                    labelText: "City and country".tr,
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
                    labelText: "Interests".tr,
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
                      Text("Set location?".tr),
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
                  child: Text("Save".tr),
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
