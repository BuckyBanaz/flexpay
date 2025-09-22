import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ReceiveController extends GetxController {
  // amount (optional)
  final RxDouble amount = 800.73.obs;

  // QR data (string that will be encoded)
  final RxString qrData = 'payto://wallet/your_wallet_address?amount=800.73'.obs;

  // wallet address (displayed below)
  final RxString walletAddress = 'fp_3K7x9Y2mNBqR5tL1p.'.obs;

  void setAmount(double v) => amount.value = v;

  // copy address to clipboard
  Future<void> copyAddress() async {
    await Clipboard.setData(ClipboardData(text: walletAddress.value));
    Get.snackbar('Copied', 'Wallet address copied to clipboard', snackPosition: SnackPosition.BOTTOM);
  }

  // share QR data (simple copy/share approach)
  Future<void> shareCode() async {
    // Simple demonstration: copy qrData to clipboard and show snackbar
    await Clipboard.setData(ClipboardData(text: qrData.value));
    Get.snackbar('Shared', 'QR data copied to clipboard (implement share_plus for real sharing)', snackPosition: SnackPosition.BOTTOM);
  }

  // stub for saving QR image (implement with RenderRepaintBoundary + path_provider + image_gallery_saver or share_plus)
  Future<void> saveQrImage() async {
    Get.snackbar('Save', 'Save QR not implemented — see comments to implement', snackPosition: SnackPosition.BOTTOM);
  }
}
