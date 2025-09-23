// lib/screens/receive/receive_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/receive/receive_controller.dart';
import 'widgets/qr_display.dart';
import 'widgets/address_box.dart';

class ReceiveScreen extends StatelessWidget {
  const ReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReceiveController c = Get.put(ReceiveController());

    // optional: key to capture QR as image
    final GlobalKey qrBoundaryKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(),
        centerTitle: true,
        title: Text('receive_money'.tr, style: const TextStyle(fontWeight: FontWeight.w600)),
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 22.0, vertical: 18),
        child: Column(
          children: [
            QRDisplay(repaintKey: qrBoundaryKey),
            const SizedBox(height: 18),
            const AddressBox(), // make sure AddressBox uses .tr internally
            const SizedBox(height: 18),
            // other helpful text/buttons
            Text(
              'share_qr_or_address'.tr,
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 30),
            // small hint/footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 14, color: Colors.white38),
                const SizedBox(width: 8),
                Text('secure_onchain'.tr, style: TextStyle(color: Colors.white38)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
