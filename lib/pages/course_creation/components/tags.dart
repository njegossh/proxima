import 'package:flutter/material.dart';
import '../controller.dart';

class TagsInput extends StatefulWidget {
  final CourseCreationController controller;

  const TagsInput({super.key, required this.controller});

  @override
  State<TagsInput> createState() => _TagsInputState();
}

class _TagsInputState extends State<TagsInput> {
  final TextEditingController _inputCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _inputCtrl,
                decoration: const InputDecoration(
                  labelText: 'Tags',
                  hintText: 'npr. Flutter, Dart, UI',
                  prefixIcon: Icon(Icons.label_outline),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                controller.addTag(_inputCtrl.text);
                _inputCtrl.clear();
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: controller.tagsList
              .map(
                (tag) => Chip(
                  label: Text(tag),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () => controller.removeTag(tag),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    super.dispose();
  }
}
