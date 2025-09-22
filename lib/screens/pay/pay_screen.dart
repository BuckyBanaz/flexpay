import 'package:flex/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/pay/pay_controller.dart';
import 'widgets/qr_display.dart';
import 'widgets/scan_placeholder.dart';
import 'widgets/cards_carousel.dart';


class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PayController c = Get.put(PayController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Pay', style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
        child: Column(
          children: [
            // segmented toggle
            Obx(() {
              final sel = c.selectedTab.value;
              return Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.02), borderRadius: BorderRadius.circular(30)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  _segmentedTab('My Code', 0, sel == 0, c),
                  _segmentedTab('Scan', 1, sel == 1, c),
                ]),
              );
            }),
            const SizedBox(height: 18),
            // main area - QR or Scan placeholder
            Obx(() => c.selectedTab.value == 0 ? const QRDisplay() : const ScanPlaceholder()),
            const SizedBox(height: 18),
            // Pay with label
            const Align(alignment: Alignment.centerLeft, child: Text('Pay with', style: TextStyle(color: Colors.white70))),
            const SizedBox(height: 8),
            const CardsCarousel(),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget _segmentedTab(String label, int idx, bool active, PayController c) {
    return GestureDetector(
      onTap: () => c.switchTab(idx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.primary: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(label, style: TextStyle(color: active ? const Color(0xFF071124) : Colors.white70, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
