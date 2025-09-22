import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class PayController extends GetxController {
  // 0 => My Code, 1 => Scan
  final RxInt selectedTab = 0.obs;

  // QR / amount
  final RxString qrData = 'flexpay://request/25.50'.obs;
  final RxDouble amount = 25.50.obs;

  // sample cards
  final RxList<Map<String, String>> cards = <Map<String, String>>[
    {
      'name': 'Sandy Chunga',
      'balance': '\$2,450.00',
      'last4': '4242',
      'color': '0xFF8B5CF6' // store color as string for demo
    },
    {
      'name': 'Sandy Chunga',
      'balance': '\$90.45',
      'last4': '1111',
      'color': '0xFF06D6A0'
    },
    {
      'name': 'Work Card',
      'balance': '\$3,200.00',
      'last4': '8888',
      'color': '0xFF00AEEF'
    },
  ].obs;

  void switchTab(int idx) => selectedTab.value = idx;

  void swapToScan() => selectedTab.value = 1;

  void shareCode() {
    // simple clipboard copy + snackbar for demo
    Clipboard.setData(ClipboardData(text: qrData.value));
    Get.snackbar('Copied', 'Payment code copied to clipboard', snackPosition: SnackPosition.BOTTOM);
  }

  void onPayWithCard(int index) {
    final card = cards[index];
    Get.snackbar('Pay', 'Paying ${amount.value.toStringAsFixed(2)} using ${card['name']}',
        snackPosition: SnackPosition.BOTTOM);
  }

  // update amount (if needed)
  void setAmount(double a) => amount.value = a;

  @override
  void onClose() {
    super.onClose();
  }
}
