import 'package:flutter/material.dart';
import 'package:proxima/main.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(Icons.edit),
            SizedBox(width: 4),
            Text(
              "Edit".tr,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
