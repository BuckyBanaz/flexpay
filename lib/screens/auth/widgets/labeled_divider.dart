// lib/widgets/labeled_divider.dart
import 'package:flutter/material.dart';

/// A horizontal divider with a centered label inside a dark rounded pill.
/// Example: "Or sign up with" or "Or continue with"
class LabeledDivider extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final Color pillColor;
  final Color lineColor;
  final double lineThickness;
  final double pillPaddingH;
  final double pillPaddingV;
  final double pillRadius;
  final EdgeInsetsGeometry margin;

  const LabeledDivider({
    super.key,
    required this.label,
    this.labelStyle,
    this.pillColor = const Color(0xFF0D0F12), // dark pill
    this.lineColor = const Color(0x33FFFFFF), // translucent white
    this.lineThickness = 1.0,
    this.pillPaddingH = 12.0,
    this.pillPaddingV = 6.0,
    this.pillRadius = 6.0,
    this.margin = const EdgeInsets.symmetric(vertical: 12.0),
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      color: Colors.white.withOpacity(0.92),
      fontSize: 13,
      fontWeight: FontWeight.w500,
    );

    return Container(
      margin: margin,
      child: Row(
        children: [
          // left line
          Expanded(
            child: Container(
              height: lineThickness,
              color: lineColor,
              margin: const EdgeInsets.only(right: 8.0),
            ),
          ),

          // pill with label
          Container(
            padding: EdgeInsets.symmetric(horizontal: pillPaddingH, vertical: pillPaddingV),
            decoration: BoxDecoration(
              color: pillColor,
              borderRadius: BorderRadius.circular(pillRadius),
              boxShadow: [
                // very subtle inner glow / shadow to match screenshot
                BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            child: Text(label, style: labelStyle ?? defaultStyle),
          ),

          // right line
          Expanded(
            child: Container(
              height: lineThickness,
              color: lineColor,
              margin: const EdgeInsets.only(left: 8.0),
            ),
          ),
        ],
      ),
    );
  }
}
