// lib/screens/home/home_screen.dart
import 'dart:ui';
import 'package:flex/constant/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import '../../constant/app_colors.dart';
import '../../models/transaction_model.dart';
import '../../modules/home/home_controller.dart';
import '../../utils/gradient_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            // Top profile row
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 18.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: const AssetImage('assets/profile.jpg'),
                        backgroundColor: Colors.grey.shade800,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'welcome'.tr,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            // If you have user's name in controller, replace with controller.userName
                            'user_name'.tr,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(IconlyLight.notification),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stack area for balance + transactions
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // background (fills bottom area)
                  Positioned.fill(
                    top: 200, // starts below the balance card area
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.base),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  // Balance card positioned near top
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppAssets.balanceFrame),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 0,
                                  end: controller.balance.value.toDouble(),
                                ),
                                duration: const Duration(milliseconds: 1000),
                                builder: (context, val, _) {
                                  return Text(
                                    '\$${val.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'available_balance'.tr,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Transactions panel that visually starts under the balance card
                  Positioned(
                    top: 260, // tune this to overlap exactly how you want
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        // small handle or space to show overlap
                        const SizedBox(height: 30),

                        // header + list inside a rounded card to mimic screenshot
                        Expanded(
                          child: Container(
                            margin: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 18.0, vertical: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'my_transactions'.tr,
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(IconlyLight.filter_2, size: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: controller.isLoading.value
                                      ? ListView.builder(
                                    padding: const EdgeInsetsDirectional.only(top: 12),
                                    itemCount: 5,
                                    itemBuilder: (_, __) => _shimmerTile(),
                                  )
                                      : ListView.separated(
                                    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 100),
                                    itemCount: controller.transactions.length,
                                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                                    itemBuilder: (_, i) {
                                      final tx = controller.transactions[i];
                                      return TweenAnimationBuilder<double>(
                                        duration: Duration(milliseconds: 400 + (i * 100)),
                                        curve: Curves.easeOut,
                                        tween: Tween<double>(begin: 0, end: 1),
                                        builder: (context, value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.translate(
                                              offset: Offset(0, 30 * (1 - value)),
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: _transactionCard(tx, context),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _shimmerTile() {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _transactionCard(TransactionModel tx, BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.86,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 22, vertical: 18),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.45),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.divider),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade800,
                  backgroundImage: (tx.image.isNotEmpty) ? AssetImage(tx.image) : null,
                  child: (tx.image.isEmpty)
                      ? Text(
                    tx.title[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white70),
                  )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tx.date,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  (tx.amount < 0 ? '-' : '+') + '\$${tx.amount.abs().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: tx.amount < 0 ? AppColors.textSecondary : AppColors.success,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
