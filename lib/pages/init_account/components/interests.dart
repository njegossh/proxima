import 'package:flutter/material.dart';
import '../controller.dart';

class Interests extends StatefulWidget {
  final InitAccountController controller;

  const Interests({super.key, required this.controller});

  @override
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
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
                  labelText: 'Interesovanja',
                  hintText: 'npr. Programiranje',
                  prefixIcon: Icon(Icons.interests_outlined),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                controller.addInterest(_inputCtrl.text);
                _inputCtrl.clear();
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: controller.interests
              .map(
                (i) => Chip(
                  label: Text(i),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () => controller.removeInterest(i),
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
