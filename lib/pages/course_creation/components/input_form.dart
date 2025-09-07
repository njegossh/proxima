import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          label: "Naziv kursa",
          icon: Icons.book,
          hint: "Unesite naziv",
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.tags,
          label: "Tagovi",
          icon: Icons.tag,
          hint: "Unesite tagove odvojene zarezom",
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.pricePerHour,
          label: "Cena (po satu)",
          icon: Icons.euro,
          hint: "Unesite cenu časova kursa po satu",
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.description,
          label: "Opis kursa",
          icon: Icons.description,
          hint: "Unesite opis",
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controller.videoURL,
          label: "URL do YouTube videa",
          icon: Icons.play_circle_fill,
          hint: "Unesite URL",
        ),
      ],
    );
  }
}
