import 'package:flex/screens/profile/widgets/glass_button.dart';
import 'package:flex/screens/profile/widgets/profile_card.dart';
import 'package:flex/screens/profile/widgets/setting_card.dart';
import 'package:flex/screens/profile/widgets/state_card.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),centerTitle: true,),
      body: ListView(
        padding: EdgeInsets.only(bottom: 100),
        children: [
          ProfileCard(),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              StatCard(
                icon: Icons.account_balance_wallet_outlined,
                gradientColors: [Color(0xFF16A34A), Color(0xFF4ADE80)], // green gradient
                amount: "\$240,399",
                label: "Total Balance",
              ),
              StatCard(
                icon: Icons.show_chart,
                gradientColors: [Color(0xFF60A5FA), Color(0xFF2563EB)], // blue gradient
                amount: "\$3,650",
                label: "Monthly Spending",
              ),
              StatCard(
                icon: Icons.attach_money,
                gradientColors: [Color(0xFFC084FC), Color(0xFFF9333EA)], // purple gradient
                amount: "\$1,200",
                label: "Saved This Month",
              ),
            ],
          ),
          const SizedBox(height: 10),
          SettingsCard(
            title: 'Personal',
            items: [
              SettingsItem(icon: IconlyLight.profile, title: 'Personal Info', subtitle: 'Update your details', onTap: () {}),
              SettingsItem(icon: IconlyLight.shield_done, title: 'Security & Privacy', subtitle: 'Manage your security', onTap: () {}),
              SettingsItem(icon: IconlyLight.notification, title: 'Notifications', subtitle: 'Push, email, SMS', onTap: () {}),
            ],
          ),
          const SizedBox(height: 10),
          SettingsCard(
            title: 'Wallet',
            items: [
              SettingsItem(icon: Icons.credit_card, title: 'Payment Methods', subtitle: 'Manage cards & accounts', onTap: () {}),
              SettingsItem(icon:  IconlyLight.wallet, title: 'Transaction Limits', subtitle: 'Set spending limits', onTap: () {}),
              SettingsItem(icon:  Icons.link_outlined, title: 'Connected Banks', subtitle: '3 accounts linked', onTap: () {}),
            ],
          ),
          const SizedBox(height: 10),
          SettingsCard(
            title: 'Support',
            items: [
              SettingsItem(icon: Icons.card_giftcard, title: 'Refer Friends', subtitle: 'Earn \$50 per referral', onTap: () {}),
              SettingsItem(icon: IconlyLight.setting, title: 'App Preferences', subtitle: 'Theme, language, etc.', onTap: () {}),
              SettingsItem(icon: Icons.help_outline, title: 'Notifications', subtitle: 'Push, email, SMS', onTap: () {}),
            ],
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlassButton(
              label: "Sign Out",
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
