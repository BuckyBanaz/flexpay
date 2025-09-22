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
        title: const Text('Receive Money', style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18),
        child: Column(
          children: [
            QRDisplay(repaintKey: qrBoundaryKey),
            const SizedBox(height: 18),
            const AddressBox(),
            const SizedBox(height: 18),
            // other helpful text/buttons
            Text('Share this QR or your wallet address to receive funds.', style: TextStyle(color: Colors.white.withOpacity(0.7))),
            const SizedBox(height: 30),
            // small hint/footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 14, color: Colors.white38),
                const SizedBox(width: 8),
                Text('Secure on-chain address', style: TextStyle(color: Colors.white38)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
