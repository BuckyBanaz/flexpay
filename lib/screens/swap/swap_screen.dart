// lib/screens/swap/swap_screen.dart
import 'dart:ui';

import 'package:flex/screens/swap/widgets/amount_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../../constant/app_colors.dart';
import '../../modules/swap/swap_controller.dart';

class SwapScreen extends StatelessWidget {
  const SwapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ensure controller is created
    final SwapController c = Get.put(SwapController());

    final radius = BorderRadius.circular(14.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
        centerTitle: true,
        title: Text('swap'.tr, style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.start),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 18.0, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 8),
            // You send
            AmountCard(
              controller: c,
              which: AmountCardType.send,
              // label should be localized inside AmountCard or passed as a key
              label: 'you_send'.tr,
              radius: radius,
            ),
            const SizedBox(height: 18),

            // swap icon
            Center(
              child: GestureDetector(
                onTap: c.swapCurrencies,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.08),
                        Colors.white.withOpacity(0.02),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // blur strength
                      child: const Icon(IconlyLight.swap, color: Colors.white, size: 28),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // You get
            AmountCard(
              controller: c,
              which: AmountCardType.get,
              label: 'you_get'.tr,
              radius: radius,
            ),
            const SizedBox(height: 20),

            // exchange rate box (reactive)
            Obx(
                  () => Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.04)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // left column (labels) - keep labels localized
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('exchange_rate_label'.tr, style: const TextStyle(fontSize: 13, color: Colors.white70)),
                        const SizedBox(height: 6),
                        Text('network_fee_label'.tr, style: const TextStyle(fontSize: 12, color: Colors.white54)),
                      ],
                    ),

                    // right column (values) - using trArgs for exchange-rate string with placeholders
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // example key: "1 {0} = {1} {2}" -> params: from, rate, to
                        Text(
                          'exchange_rate_value'.trArgs([c.from, c.exchangeRateString, c.to]),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 6),
                        Text('\$${c.networkFee.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Bottom big button
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0, vertical: 30),
                child: ElevatedButton(
                  onPressed: () {
                    // perform swap (call controller method)
                    // c.performSwap();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Using trArgs to inject dynamic text into button label
                      Obx(() {
                        // example: "Swap {0} {1}" where {0} = youSendText, {1} = from currency
                        return Text(
                          'swap_action'.trArgs([c.youSendText.value, c.from]),
                          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
