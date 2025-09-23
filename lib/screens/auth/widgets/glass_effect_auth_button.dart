import 'dart:ui';
import 'package:flutter/material.dart';

class GlassAuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget leading; // icon or image
  final String label;
  final double height;
  final double radius;

  const GlassAuthButton({
    super.key,
    required this.onPressed,
    required this.leading,
    required this.label,
    this.height = 52,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.02),
                  Colors.white.withOpacity(0.01),
                ],
              ),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: Colors.white.withOpacity(0.04)),

            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // leading icon / image
                  SizedBox(width: 36, child: Center(child: leading)),
                  const SizedBox(width: 2),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
