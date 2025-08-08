import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
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
