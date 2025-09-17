import 'package:flutter/material.dart';
import '../constant/app_colors.dart';

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry? padding;

  const GradientScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final Color start = AppColors.gradientStart;
    final Color mid = AppColors.gradientMid;
    final Color end = AppColors.gradientEnd;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          // Main gradient only — no extra overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [start, mid, end],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.5, 1.0], // tweak these if needed
              ),
            ),
          ),

          SafeArea(
            child: Padding(padding: padding ?? EdgeInsets.zero, child: body),
          ),
        ],
      ),
    );
  }
}
