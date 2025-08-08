import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 1,
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [Icon(Icons.edit), Text("Izmeni")]),
        ),
      ),
    );
  }
}
