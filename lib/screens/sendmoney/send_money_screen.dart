// lib/screens/sendmoney/send_money_screen.dart
import 'package:flex/constant/app_assets.dart';
import 'package:flex/constant/app_colors.dart';
import 'package:flex/screens/sendmoney/widgets/glass_text_field.dart';
import 'package:flex/screens/sendmoney/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:get/get.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  // which card is selected: 0 or 1
  int selectedCard = 0;

  final recentAvatars = [
    'https://i.pravatar.cc/150?img=32',
    'https://i.pravatar.cc/150?img=12',
    'https://i.pravatar.cc/150?img=8',
    'https://i.pravatar.cc/150?img=47',
  ];

  @override
  Widget build(BuildContext context) {
    final screenPadding = 18.0;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          visualDensity: VisualDensity.compact,
          splashRadius: 20,
        ),
        title: Text(
          'send_money_title'.tr,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white70),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: screenPadding, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount label + big amount
            Center(
              child: Column(
                children: [
                  Text(
                    'amount_label'.trArgs(['SR']),
                    style: GoogleFonts.poppins(color: Colors.white60, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$500.4', // dynamic: replace with controller value when available
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Search field
            GlassTextField(
              hint: 'search_hint'.tr,
              prefixIcon: Icon(IconlyLight.search, color: AppColors.primary, size: 18),
              onChanged: (v) {},
            ),
            const SizedBox(height: 18),

            // Recent label + avatars
            Text('recent'.tr, style: GoogleFonts.poppins(color: Colors.white70, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 0),
                itemCount: recentAvatars.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, idx) {
                  final displayName = idx == 0 ? 'john'.tr : idx == 1 ? 'jane'.tr : idx == 2 ? 'mike'.tr : 'emily'.tr;
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [const Color(0xFF7B61FF), AppColors.primary],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          padding: const EdgeInsets.all(3),
                          child: CircleAvatar(
                            radius: 23,
                            backgroundImage: NetworkImage(recentAvatars[idx]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        displayName,
                        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
                      )
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            Text('from_label'.tr, style: GoogleFonts.poppins(color: Colors.white70, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            // Cards list
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selectedCard = 0),
                    child: PaymentCard(
                      selected: selectedCard == 0,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFA855F7), Color(0xFF9333EA), Color(0xFF7E22CE)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      cardNumber: '5000 0000 0000 0000',
                      holderName: 'Sandy Chungus',
                      balance: 12450.00,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => setState(() => selectedCard = 1),
                    child: PaymentCard(
                      selected: selectedCard == 1,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF22D3EE), Color(0xFF14B8A6), Color(0xFF4ADE80)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      cardNumber: '5000 0000 0000 0000',
                      holderName: 'Sandy Chungus',
                      balance: 8320.50,
                    ),
                  ),
                  const SizedBox(height: 90), // spacing for bottom button
                ],
              ),
            ),
          ],
        ),
      ),
      // Floating send button
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0, vertical: 30),
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
                Icon(Icons.send_rounded, color: Colors.white),
                const SizedBox(width: 12),
                Text('send_action_label'.trArgs(['\$500.4']), style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
