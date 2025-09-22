import 'dart:ui';

import 'package:flex/constant/app_colors.dart';
import 'package:flex/utils/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../stats/stats_screen.dart';
import '../wallet/wallet_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    WalletScreen(),
     ProfileScreen(),
    StatsScreen(),
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background similar to your AppColors
      body: Container(

        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              // preserve pages with IndexedStack
              IndexedStack(index: _selectedIndex, children: _pages),
              // Positioned Bottom navigation
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: GlassBottomNav(
                  selectedIndex: _selectedIndex,
                  onTap: _onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlassBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const GlassBottomNav({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: IconlyLight.home,
                label: 'Home',
                isActive: selectedIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: IconlyLight.wallet,
                label: 'Wallet',
                isActive: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
              _NavItem(
                icon: IconlyLight.profile,
                label: 'Profile',
                isActive: selectedIndex == 2,
                onTap: () => onTap(2),
              ),
              _NavItem(
                icon: IconlyLight.chart,
                label: 'Analytics',
                isActive: selectedIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isActive ? AppColors.primary : AppColors.textFaded,
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------- SAMPLE SCREENS -------------------



class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(body: Center(child: Text("Activity")));
  }
}
