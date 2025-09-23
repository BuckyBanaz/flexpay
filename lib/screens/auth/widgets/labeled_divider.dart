import 'package:flutter/material.dart';

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
    this.pillColor = const Color(0xFF0D0F12),
    this.lineColor = const Color(0x33FFFFFF),
    this.lineThickness = 1.0,
    this.pillPaddingH = 12.0,
    this.pillPaddingV = 6.0,
    this.pillRadius = 6.0,
    this.margin = const EdgeInsetsDirectional.symmetric(vertical: 12.0),
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
          Expanded(
            child: Container(
              height: lineThickness,
              color: lineColor,
              margin: const EdgeInsetsDirectional.only(end: 8.0),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: pillPaddingH, vertical: pillPaddingV),
            decoration: BoxDecoration(
              color: pillColor,
              borderRadius: BorderRadius.circular(pillRadius),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            child: Text(label, style: labelStyle ?? defaultStyle),
          ),
          Expanded(
            child: Container(
              height: lineThickness,
              color: lineColor,
              margin: const EdgeInsetsDirectional.only(start: 8.0),
            ),
          ),
        ],
      ),
    );
  }
}
