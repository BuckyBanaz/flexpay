// lib/screens/pay/widgets/scan_placeholder.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanPlaceholder extends StatelessWidget {
  const ScanPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    // final PayController c = Get.find(); // if needed later
    return Column(
      children: [
        // Use CustomPaint to draw dashed rounded rect
        Container(
          height: 220,
          width: double.infinity,
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 18),
          child: CustomPaint(
            painter: DashedRRectPainter(
              color: Colors.white24,
              strokeWidth: 1.2,
              dashWidth: 8,
              dashGap: 6,
              radius: 12,
            ),
            child: Container(
              padding: const EdgeInsetsDirectional.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.01),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.camera_alt_outlined, size: 36, color: Colors.white24),
                  const SizedBox(height: 8),
                  Text(
                    'scan_instructions'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54),
                  ),
                ]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('scan_mode_placeholder'.tr, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

/// Painter that draws a dashed rounded-rect along the provided rect.
class DashedRRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final double radius;

  DashedRRectPainter({
    this.color = Colors.white24,
    this.strokeWidth = 1.2,
    this.dashWidth = 6,
    this.dashGap = 4,
    this.radius = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double start = distance;
        final double end = (distance + dashWidth).clamp(0.0, metric.length);
        final Path extract = metric.extractPath(start, end);
        canvas.drawPath(extract, paint);
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedRRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.radius != radius;
  }
}
