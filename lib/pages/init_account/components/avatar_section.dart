import 'package:flutter/material.dart';
import '../components/avatar.dart';

class AvatarSection extends StatelessWidget {
  final String? imageString;
  final VoidCallback onPickImage;

  const AvatarSection({
    super.key,
    required this.imageString,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Hero(
            tag: 'profile_avatar',
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: AvatarWidget(imageString: imageString),
            ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: onPickImage,
            icon: const Icon(Icons.camera_alt),
            label: Text(
              imageString == null ? "Izaberi sliku" : "Promeni sliku",
            ),
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}