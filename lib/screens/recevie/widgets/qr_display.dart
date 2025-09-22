import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../modules/receive/receive_controller.dart';


class QRDisplay extends StatelessWidget {
  // allow parent to pass a repaint key if they want to capture image
  final GlobalKey? repaintKey;
  const QRDisplay({super.key, this.repaintKey});

  @override
  Widget build(BuildContext context) {
    final ReceiveController c = Get.find();
    return Column(
      children: [
        // Amount label
        const SizedBox(height: 6),
        const Text('Request Amount (Optional)', style: TextStyle(color: Colors.white54)),
        const SizedBox(height: 6),
        Obx(() => Text('\$${c.amount.value.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white))),

        const SizedBox(height: 18),

        // QR box: use RepaintBoundary if parent passed a key for saving
        RepaintBoundary(
          key: repaintKey,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.02),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Obx(() => QrImageView(
                  data: c.qrData.value,
                  version: QrVersions.auto,
                  size: 200.0,
                  gapless: false,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                )),
              ),
            ),
          ),
        ),

        const SizedBox(height: 18),

        // action buttons row (Share / Save QR)
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: c.shareCode,
                icon: const Icon(Icons.share, color: Colors.white70),
                label: const Text('Share', style: TextStyle(color: Colors.white70)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.02),
                  side: BorderSide(color: Colors.white.withOpacity(0.04)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: c.saveQrImage,
                icon: const Icon(Icons.download_outlined, color: Color(0xFF071124)),
                label: const Text('Save QR', style: TextStyle(color: Color(0xFF071124))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF13E0E9),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
