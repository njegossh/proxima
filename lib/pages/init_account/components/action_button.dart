import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final bool isInitialized;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.isInitialized,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isInitialized ? 'Ažurirajte profil' : 'Kreirajte profil',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(width: 12),
          AnimatedRotation(
            turns: 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isInitialized ? Icons.update : Icons.arrow_forward,
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}