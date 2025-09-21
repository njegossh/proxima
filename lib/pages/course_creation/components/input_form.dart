import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/course_creation/components/tags.dart';
import 'package:proxima/pages/course_creation/controller.dart';
import '../../init_account/components/custom_text_field.dart';

class InputForm extends StatelessWidget {
  final CourseCreationController controller;

  const InputForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: controller.name,
          label: "Name".tr,
          icon: Icons.book,
          hint: "Enter name for the course".tr,
        ),
        const SizedBox(height: 16),
        TagsInput(controller: controller),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.pricePerHour,
          label: "${"Price".tr}/h",
          icon: Icons.euro,
          hint: "Enter the price for course class".tr,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.description,
          label: "Description".tr,
          icon: Icons.description,
          hint: "Enter course description",
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.videoURL,
          label: "Youtube video URL".tr,
          icon: Icons.play_circle_fill,
          hint: "Enter YT video URL".tr,
        ),
      ],
    );
  }
}
