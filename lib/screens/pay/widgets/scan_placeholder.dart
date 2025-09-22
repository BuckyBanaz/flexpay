import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../modules/pay/pay_controller.dart';

class ScanPlaceholder extends StatelessWidget {
  const ScanPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final PayController c = Get.find();
    return Column(
      children: [
        // Use CustomPaint to draw dashed rounded rect
        Container(
          height: 220,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: CustomPaint(
            painter: DashedRRectPainter(
              color: Colors.white24,
              strokeWidth: 1.2,
              dashWidth: 8,
              dashGap: 6,
              radius: 12,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.01),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(Icons.camera_alt_outlined, size: 36, color: Colors.white24),
                  SizedBox(height: 8),
                  Text(
                    'Position the QR code within the frame to scan it',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54),
                  ),
                ]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Scan mode - camera placeholder', style: TextStyle(color: Colors.white70)),
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

    // Draw dashed along the path using PathMetrics
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
