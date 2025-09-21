import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/init_account/components/interests.dart';
import 'package:proxima/pages/init_account/controller.dart';
import 'section_header.dart';
import 'custom_text_field.dart';
import 'location_section.dart';
import 'action_button.dart';

class FormCard extends StatelessWidget {
  final InitAccountController controller;
  final bool isInitialized;
  final VoidCallback onActionPressed;

  const FormCard({
    super.key,
    required this.controller,
    required this.isInitialized,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      margin: EdgeInsets.all(0),
      color: Theme.of(context).colorScheme.surface,
      shadowColor: colorScheme.shadow.withAlpha(25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           SectionHeader(
              title: "General information".tr,
              icon: Icons.person_outline,
            ),
            SizedBox(height: 20),
            _buildFormFields(),
            SizedBox(height: 32),
            SectionHeader(
              title: "Location and preferences".tr,
              icon: Icons.location_on_outlined,
            ),
            SizedBox(height: 20),
            LocationSection(
              controller: controller,
              isInitialized: isInitialized,
            ),
            SizedBox(height: 32),
            ActionButton(
              isInitialized: isInitialized,
              onPressed: onActionPressed,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: controller.firstNameCtrl,
                label: "Name".tr,
                icon: Icons.person_outline,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: controller.lastNameCtrl,
                label: "Last name".tr,
                icon: Icons.person_outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.descriptionCtrl,
          label: "About".tr,
          icon: Icons.description_outlined,
          maxLines: 3,
          hint: "Say something about yourself".tr,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.locationDescCtrl,
          label: "City and country".tr,
          icon: Icons.location_city_outlined,
          hint: "ex. Belgrade, Serbia",
        ),
        const SizedBox(height: 16),
        Interests(controller: controller),
      ],
    );
  }
}
