import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';

class GlowingTabIndicator extends StatelessWidget {
  final double width;
  final double height;

  const GlowingTabIndicator({
    Key? key,
    this.width = 30,
    this.height = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // gradient for the neon line (left bright cyan -> right purple fade)
    final gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        AppColors.primary,
        AppColors.primary.withOpacity(0.9),
        AppColors.accent.withOpacity(0.9),
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    return SizedBox(
      height: 20, // enough space for glow above/below
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // blurred glow layer (bigger, more transparent)
            // Using ImageFiltered to blur this layer for a soft spread
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                width: width + 40, // wider glow spread
                height: height + 10,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                // make it translucent so blur looks like glow
                // use opacity by wrapping with Opacity widget if needed
              ),
            ),

            // subtle second glow (less blur) for depth
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                width: width + 18,
                height: height + 6,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),

            // the crisp visible line on top
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  // tiny colored glow to make edges pop
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.55),
                    blurRadius: 8,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 0),
                  ),
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.18),
                    blurRadius: 14,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}