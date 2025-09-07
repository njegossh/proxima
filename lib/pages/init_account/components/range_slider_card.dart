import 'package:flutter/material.dart';

class RangeSliderCard extends StatelessWidget {
  final double range;
  final ValueChanged<double> onRangeChanged;

  const RangeSliderCard({
    super.key,
    required this.range,
    required this.onRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.radar, color: colorScheme.primary),
              const SizedBox(width: 12),
              Text(
                "Radijus pretrage: ${range.toStringAsFixed(0)} km",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 10,
              ),
              overlayShape: const RoundSliderOverlayShape(
                overlayRadius: 20,
              ),
            ),
            child: Slider(
              min: 1,
              max: 100,
              divisions: 99,
              value: range,
              label: "${range.toStringAsFixed(0)} km",
              onChanged: onRangeChanged,
            ),
          ),
        ],
      ),
    );
  }
}