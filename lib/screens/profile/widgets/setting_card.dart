import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';

// Example AppColors with primary color. Replace with your AppColors import.

/// Frosted / glass Settings card with gradient icon boxes.
class SettingsCard extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;
  final double borderRadius;

  const SettingsCard({
    Key? key,
    required this.title,
    required this.items,
    this.borderRadius = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
            ),
          ),
        ),

        // Glass card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Stack(
              children: [
                // Background gradient + overlay (visible behind blur)
                Container(
                  height: items.length * 86.0, // approx height; it's fine because child will expand
                  decoration: BoxDecoration(

                  ),
                ),

                // Backdrop blur
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // this color gives the frosted feel
                      color: Colors.white.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.04),
                      ),
                      boxShadow: [

                        // slight inner glow to emulate glass edges
                        BoxShadow(
                          color: Colors.white.withOpacity(0.02),
                          blurRadius: 0,
                          spreadRadius: 0.5,
                          offset: const Offset(-1, -1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(items.length, (index) {
                        final item = items[index];
                        final isLast = index == items.length - 1;
                        return Column(
                          children: [
                            _SettingsRow(item: item),
                            if (!isLast)
                              Divider(
                                height: 1,
                                color: Colors.white.withOpacity(0.04),
                              ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
}

class _SettingsRow extends StatelessWidget {
  final SettingsItem item;
  const _SettingsRow({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: Row(
            children: [
              // Icon box with stronger top-left -> bottom-right gradient
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary,width: 0.8),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // stronger gradient as requested
                    colors: [
                      Color(0XFF22D3EE).withOpacity(0.2),
                      Color(0XFFA855F7).withOpacity(0.2),
                    ],
                  ),
                  boxShadow: [
                    // subtle inner shadow to give depth
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(item.icon, color: AppColors.primary, size: 22),
                ),
              ),

              const SizedBox(width: 14),

              // Titles
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Chevron
              Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.5),
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ Example usage (can be removed) ------------------
class DemoSettingsScreen extends StatelessWidget {
  const DemoSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24.0),
          child: SettingsCard(
            title: 'Personal',
            items: [
              SettingsItem(icon: Icons.person, title: 'Personal Info', subtitle: 'Update your details', onTap: () {}),
              SettingsItem(icon: Icons.shield, title: 'Security & Privacy', subtitle: 'Manage your security', onTap: () {}),
              SettingsItem(icon: Icons.notifications, title: 'Notifications', subtitle: 'Push, email, SMS', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
