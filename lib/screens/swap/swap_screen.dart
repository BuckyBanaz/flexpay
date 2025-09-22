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
        title: const Text('Swap', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 8),
            // You send
            AmountCard(
              controller: c,
              which: AmountCardType.send,
              label: 'You send',
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
                Colors.white.withOpacity(0.08), // halki transparency
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
              label: 'You get',
              radius: radius,
            ),
            const SizedBox(height: 20),
            // exchange rate box (reactive)
            Obx(
                  () => Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.04)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                      Text('Exchange Rate', style: TextStyle(fontSize: 13, color: Colors.white70)),
                      SizedBox(height: 6),
                      Text('Network Fee', style: TextStyle(fontSize: 12, color: Colors.white54)),
                    ]),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('1 ${c.from} = ${c.exchangeRateString} ${c.to}',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Text('\$${c.networkFee.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white70)),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50,),
            // Bottom big button
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 30),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Swap ${c.youSendText.value} ${c.from}', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700)),
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