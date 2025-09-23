// lib/screens/pay/widgets/qr_display.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../modules/pay/pay_controller.dart';

class QRDisplay extends StatelessWidget {
  const QRDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final PayController c = Get.find();
    return Column(
      children: [
        // QR card with glow & rounded white frame
        Container(
          padding: const EdgeInsetsDirectional.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.02),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => QrImageView(
                data: c.qrData.value,
                size: 160,
                gapless: false,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              )),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text('requesting'.tr, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        Obx(() => Text('\$ ${c.amount.value.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700))),
        const SizedBox(height: 12),
        SizedBox(
          width: 160,
          child: OutlinedButton(
            onPressed: c.shareCode,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white.withOpacity(0.06)),
              backgroundColor: Colors.white.withOpacity(0.02),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('share_code'.tr, style: const TextStyle(color: Colors.white70)),
          ),
        ),
      ],
    );
  }
}
