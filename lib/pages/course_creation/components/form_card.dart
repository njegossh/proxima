import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/course_creation/controller.dart';
import 'input_form.dart';
import 'action_button.dart';

class FormCard extends StatelessWidget {
  final CourseCreationController controller;

  const FormCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputForm(controller: controller),
          const SizedBox(height: 24),
          ActionButton(
            text: 'Save'.tr,
            onPressed: () {
              controller.saveCourse(context);
            },
          ),
        ],
      ),
    );
  }
}
