// lib/screens/profile/profile_screen.dart
import 'package:flex/routes/appRoutes.dart';
import 'package:flex/screens/profile/widgets/glass_button.dart';
import 'package:flex/screens/profile/widgets/profile_card.dart';
import 'package:flex/screens/profile/widgets/setting_card.dart';
import 'package:flex/screens/profile/widgets/state_card.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(bottom: 100),
        children: [
          const ProfileCard(),
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatCard(
                  icon: Icons.account_balance_wallet_outlined,
                  gradientColors: const [Color(0xFF16A34A), Color(0xFF4ADE80)], // green gradient
                  amount: "\$240,399", // keep dynamic if you fetch real data
                  label: 'total_balance'.tr,
                ),
                StatCard(
                  icon: Icons.show_chart,
                  gradientColors: const [Color(0xFF60A5FA), Color(0xFF2563EB)], // blue gradient
                  amount: "\$3,650",
                  label: 'monthly_spending'.tr,
                ),
                StatCard(
                  icon: Icons.attach_money,
                  gradientColors: const [Color(0xFFC084FC), Color(0xFFF9333EA)], // purple gradient
                  amount: "\$1,200",
                  label: 'saved_this_month'.tr,
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          SettingsCard(
            title: 'personal'.tr,
            items: [
              SettingsItem(
                icon: IconlyLight.profile,
                title: 'personal_info'.tr,
                subtitle: 'update_your_details'.tr,
                onTap: () {},
              ),
              SettingsItem(
                icon: IconlyLight.shield_done,
                title: 'security_privacy'.tr,
                subtitle: 'manage_your_security'.tr,
                onTap: () {},
              ),
              SettingsItem(
                icon: IconlyLight.notification,
                title: 'notifications'.tr,
                subtitle: 'push_email_sms'.tr,
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 10),

          SettingsCard(
            title: 'wallet'.tr,
            items: [
              SettingsItem(
                icon: Icons.credit_card,
                title: 'payment_methods'.tr,
                subtitle: 'manage_cards_accounts'.tr,
                onTap: () {},
              ),
              SettingsItem(
                icon: IconlyLight.wallet,
                title: 'transaction_limits'.tr,
                subtitle: 'set_spending_limits'.tr,
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.link_outlined,
                title: 'connected_banks'.tr,
                subtitle: 'accounts_linked'.trArgs(['3']), // use args if you want dynamic number
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 10),

          SettingsCard(
            title: 'support'.tr,
            items: [
              SettingsItem(
                icon: Icons.card_giftcard,
                title: 'refer_friends'.tr,
                subtitle: 'earn_referral'.trArgs(['50']), // e.g. insert 50 via args
                onTap: () {},
              ),
              SettingsItem(
                icon: IconlyLight.setting,
                title: 'app_preferences'.tr,
                subtitle: 'theme_language'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.language);
                },
              ),
              SettingsItem(
                icon: Icons.help_outline,
                title: 'help_support'.tr,
                subtitle: 'help_subtitle'.tr,
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlassButton(
              label: 'sign_out'.tr,
              icon: Icons.logout, // or null if you don't want icon
              onPressed: () {
                // sign out logic
              },
              height: 46,
            ),
          ),
        ],
      ),
    );
  }
}
