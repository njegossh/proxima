import 'dart:ui';
import 'package:flutter/material.dart';

class FrostedGlassCard extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const FrostedGlassCard({
    super.key,
    this.width = 300,
    this.height = 200,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(10),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.black.withAlpha(10),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          Center(child: child),
        ],
      ),
    );
  }
}
