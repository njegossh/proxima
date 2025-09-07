import 'package:flutter/material.dart';
import 'package:proxima/pages/init_account/controller.dart';
import 'range_slider_card.dart';
import 'location_checkbox.dart';

class LocationSection extends StatelessWidget {
  final InitAccountController controller;
  final bool isInitialized;

  const LocationSection({
    super.key,
    required this.controller,
    required this.isInitialized,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSliderCard(
          range: controller.range,
          onRangeChanged: (value) => controller.range = value,
        ),
        const SizedBox(height: 16),
        LocationCheckbox(
          trackLocation: controller.trackLocation,
          onChanged: isInitialized ? controller.trackLocationChange : null,
        ),
      ],
    );
  }
}