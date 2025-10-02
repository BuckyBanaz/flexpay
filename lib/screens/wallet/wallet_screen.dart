// lib/screens/wallet/wallet_screen.dart
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
        title: Text('wallet'.tr, textAlign: TextAlign.start),
        actions: [const Icon(Icons.more_vert)],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
          child: ListView(
            padding: const EdgeInsetsDirectional.only(start: 8, end: 8, bottom: 100),
            children: [
              // Tabs
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'cards'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
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
                      'account'.tr,
                      style: TextStyle(color: Colors.grey),
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
                  onPageChanged: (index) => controller.currentIndex.value = index,
                  itemBuilder: (context, index) {
                    final card = controller.cards[index];

                    final double distance = (_page - index).abs().clamp(0.0, 1.0);
                    final double scale = 1 - (distance * 0.06);
                    final double shadowBlur = 18 + (1 - distance) * 16;
                    final double shadowOpacity = 0.20 + (1 - distance) * 0.18;

                    return Transform.scale(
                      scale: scale,
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 8),
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
                              alignment: AlignmentDirectional.topEnd,
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
                                Expanded(
                                  child: Text(
                                    card["name"].toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
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
                      margin: const EdgeInsetsDirectional.symmetric(horizontal: 6),
                      width: active ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : Colors.grey.withOpacity(0.6),
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

              // Customization Button
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: GestureDetector(
                  onTapDown: (_) => setState(() {}),
                  onTapUp: (_) {
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
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
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
                            'customization'.tr,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedActionButton(
                      icon: Icons.send,
                      label: 'send'.tr,
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
                      label: 'swap'.tr,
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
                      label: 'receive'.tr,
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
                      label: 'pay'.tr,
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
                    padding: const EdgeInsetsDirectional.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsetsDirectional.all(16),
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
                                  Icon(CupertinoIcons.qrcode, color: AppColors.primary, size: 20),
                                  const SizedBox(width: 10),
                                  Text(
                                    '+ ' + 'add_card'.tr,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.maybePop(context);
                                    },
                                    child: Text(
                                      'cancel'.tr,
                                      style: TextStyle(
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
                                'add_card_subtitle'.tr,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Card number field label
                              Text(
                                'card_number'.tr,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _inputField(
                                hint: 'card_number_hint'.tr,
                                context: context,
                              ),

                              const SizedBox(height: 12),

                              // Card holder name label
                              Text(
                                'card_holder_name'.tr,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _inputField(hint: 'card_holder_hint'.tr, context: context),

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
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    'add_card'.tr,
                                    style: TextStyle(
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
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 14),
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
      textAlign: TextAlign.start,
    );
  }
}
