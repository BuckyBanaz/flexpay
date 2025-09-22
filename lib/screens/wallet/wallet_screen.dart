import 'dart:ui';

import 'package:flex/screens/wallet/widgets/animated_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../../constant/app_colors.dart';
import '../../modules/wallet/wallet_controller.dart';
import '../../routes/appRoutes.dart';
import '../../utils/gradient_scaffold.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Keep using your existing AppColors, GradientScaffold and WalletController
// Make sure those are available in your project.

class WalletScreen extends StatefulWidget {
  WalletScreen({super.key});
  final WalletController controller = Get.put(WalletController());

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  double _page = 0.0;

  // track press state for action buttons (0..3)
  final Map<int, bool> _isPressed = {0: false, 1: false, 2: false, 3: false};

  // animation for Add Card panel entrance
  late AnimationController _panelAnimController;
  late Animation<Offset> _panelOffsetAnim;
  late Animation<double> _panelOpacityAnim;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.88);
    _pageController.addListener(() {
      setState(() {
        _page = _pageController.page ?? _pageController.initialPage.toDouble();
      });
    });

    _panelAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _panelOffsetAnim =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _panelAnimController,
            curve: Curves.easeOutQuad,
          ),
        );

    _panelOpacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _panelAnimController, curve: Curves.easeOut),
    );

    // start entrance animation a little after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _panelAnimController.forward();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _panelAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Wallet"),
        actions: [const Icon(Icons.more_vert)],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 100),
            children: [
              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Cards",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 3,
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Text(
                      "Account",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // Card Carousel with animated scale & shadow
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: controller.cards.length,
                  onPageChanged: (index) =>
                      controller.currentIndex.value = index,
                  itemBuilder: (context, index) {
                    final card = controller.cards[index];

                    // closeness factor: 1.0 for active, decreases for others
                    final double distance = (_page - index).abs().clamp(
                      0.0,
                      1.0,
                    );
                    final double scale =
                        1 - (distance * 0.06); // active card slightly bigger
                    final double shadowBlur =
                        18 + (1 - distance) * 16; // active card more blur
                    final double shadowOpacity = 0.20 + (1 - distance) * 0.18;

                    return Transform.scale(
                      scale: scale,
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: List<Color>.from(card["gradient"] as List),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(shadowOpacity),
                              blurRadius: shadowBlur,
                              offset: Offset(0, 8 * (1 - distance)),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.wifi,
                                color: Colors.white.withOpacity(0.95),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              card["number"].toString(),
                              style: GoogleFonts.robotoMono(
                                fontSize: 18,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  card["name"].toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Image.network(
                                  "https://img.icons8.com/color/48/mastercard-logo.png",
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Animated Page Indicator
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.cards.length, (index) {
                    final bool active = controller.currentIndex.value == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: active ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.primary
                            : Colors.grey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: active
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),

              // Customization Button with gentle tap scale
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTapDown: (_) => setState(() {}),
                  onTapUp: (_) {
                    // open customization
                    Get.toNamed(AppRoutes.customization);
                    setState(() {});
                  },
                  onTapCancel: () => setState(() {}),
                  child: AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.03),
                                Colors.white.withOpacity(0.01),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
                              width: 1.2,
                            ),
                          ),
                          child: Text(
                            "Customization",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons with press scale animation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedActionButton(
                      icon: Icons.send,
                      label: "Send",
                      gradientColors: [
                        const Color(0xFFEC4899),
                        const Color(0xFF8B5CF6),
                      ],
                      onPressed: () {
                        Get.toNamed(AppRoutes.sendMoney);
                      },
                    ),
                    AnimatedActionButton(
                      icon: Icons.swap_horiz,
                      label: "Swap",
                      gradientColors: [
                        const Color(0xFF38BDF8),
                        const Color(0xFF06B6D4),
                      ],
                      onPressed: () {
                        Get.toNamed(AppRoutes.swap);
                      },
                    ),
                    AnimatedActionButton(
                      icon: Icons.arrow_downward,
                      label: "Receive",
                      gradientColors: [
                        const Color(0xFF4ADE80),
                        const Color(0xFF22C55E),
                      ],
                      onPressed: () {
                        Get.toNamed(AppRoutes.receive);
                      },
                    ),
                    AnimatedActionButton(
                      icon: Icons.payment,
                      label: "Pay",
                      gradientColors: [
                        const Color(0xFF3B82F6),
                        const Color(0xFF06B6D4),
                      ],
                      onPressed: () {
                        Get.toNamed(AppRoutes.pay);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Add Card Section — entrance animation (slide + fade)
              const SizedBox(height: 6),
              SlideTransition(
                position: _panelOffsetAnim,
                child: FadeTransition(
                  opacity: _panelOpacityAnim,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // pill shape
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.03),
                                Colors.white.withOpacity(0.01),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),

                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header row: QR icon, + Add Card, Cancel
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.qrcode,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "+ Add Card",
                                        style: GoogleFonts.poppins(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      // Cancel action
                                      Navigator.maybePop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 14),

                              Text(
                                "Add your debit/credit card",
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Card number field label
                              Text(
                                "Card number",
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.75),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _inputField(
                                hint: "XXXX XXXX XXXX XXXX",
                                context: context,
                              ),

                              const SizedBox(height: 12),

                              // Card holder name label
                              Text(
                                "Card holder name",
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.75),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _inputField(hint: "Full name", context: context),

                              const SizedBox(height: 18),

                              // Add Card button (white full width)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // add card action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    "Add Card",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({required String hint, required BuildContext context}) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.25)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.02),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.04),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.9),
            width: 1.4,
          ),
        ),
      ),
    );
  }
}
