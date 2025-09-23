// lib/screens/pay/widgets/cards_carousel.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constant/app_assets.dart';
import '../../../modules/pay/pay_controller.dart';

class CardsCarousel extends StatelessWidget {
  const CardsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final PayController c = Get.find();
    return Obx(() {
      return SizedBox(
        height: 130,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
          itemCount: c.cards.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, i) {
            final card = c.cards[i];
            final Color cardColor = Color(int.parse(card['color']!));

            return GestureDetector(
              onTap: () => c.onPayWithCard(i),
              child: Container(
                width: 200,
                padding: const EdgeInsetsDirectional.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [cardColor.withOpacity(0.95), cardColor.withOpacity(0.8)]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: cardColor.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 6))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(AppAssets.chip)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white24),
                        child: Text('balance'.tr, style: const TextStyle(fontSize: 10, color: Colors.white70)),
                      )
                    ]),
                    const SizedBox(height: 10),
                    Text(card['name']!, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                    const SizedBox(height: 6),
                    Text(card['balance']!, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white70)),
                    const Spacer(),
                    Row(
                      children: [
                        Text('•••• ${card['last4']}', style: const TextStyle(color: Colors.white38)),
                        const Spacer(),
                        // VISA badge (simple circular)
                        Container(
                          height: 20,
                          width: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(AppAssets.visaCard)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text('VISA', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
