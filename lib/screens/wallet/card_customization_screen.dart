// lib/screens/card_customization/card_customization_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class CardCustomizationScreen extends StatelessWidget {
  const CardCustomizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: Colors.yellow, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'customisable'.tr,
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert, color: Colors.white),
                ],
              ),

              const SizedBox(height: 28),

              // 🔹 Card Preview
              Center(
                child: Container(
                  height: 180,
                  width: 280,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2F4F),
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3E465D), Color(0xFF1D2136)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        end: -30,
                        top: -30,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('brand_name'.tr,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            const Spacer(),
                            Text('card_holder_name'.tr,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                )),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                Image.asset(
                                  "assets/visa.png", // put VISA logo in assets
                                  height: 28,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Material options
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.cyan, width: 1.4),
                      ),
                      child: Center(
                        child: Text('premium_plastic'.tr, style: GoogleFonts.poppins(color: Colors.white, fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.08),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('solid_steel_metal'.tr, style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13)),
                          const SizedBox(width: 6),
                          const Icon(CupertinoIcons.lock_fill, size: 14, color: Colors.white54),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🔹 Title + Subtitle
              Center(
                child: Column(
                  children: [
                    Text('material_color_label'.trArgs(['Premium Plastic', 'Space Grey']),
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 8),
                    Text(
                      'material_description'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // 🔹 Color swatches
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildColorCircle(Colors.cyan, true),
                  buildColorCircle(Colors.red, false),
                  buildColorCircle(Colors.purple, false),
                ],
              ),

              const Spacer(),

              // 🔹 CTA Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('get_your_card'.tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Color circle builder
  Widget buildColorCircle(Color color, bool selected) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          if (selected) const Icon(Icons.check, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}
