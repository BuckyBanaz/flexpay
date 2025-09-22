import 'package:flutter/material.dart';

class AppColors {
  // Background gradient (deep dark → rich purple → violet glow)
  static const Color gradientStart = Color(0xFF1F2937); // very dark top
  static const Color gradientMid   = Color(0xFF532175); // deep violet (mid)
  static const Color gradientEnd   = Color(0xFF111827); // purple glow bottom

  // Center glow color (a bit brighter than gradientMid)
  static const Color scaffold  = Color(0xFF19173D);
  static const Color centerPurple  = Color(0xFF5B1FB0);

  // Neon / accent
  static const Color primary       = Color(0xFF06B6D4); // neon cyan (main accent)
  static const Color primaryMuted  = Color(0xFF6A4DFF); // soft neon violet
  static const Color accent = Color(0xFF6B4BFF);
  // Text colors
  static const Color textPrimary   = Colors.white;
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textFaded     = Color(0xFF7A6D9E);

  // Status
  static const Color success = Color(0xFF35D07F);
  static const Color error   = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFFC107);

  // Card backgrounds & surfaces
  static const Color cardBg        = Color(0xFF1F2937);
  static const Color cardbox        = Color(0xFF6B7280);
  static const Color cardHighlight = Color(0xFF3C1F52);

  // Borders / dividers
  static const Color divider       = Color(0x22FFFFFF);

  // Small translucents
  static const Color white12 = Color(0x1FFFFFFF);
  static const Color black50 = Color(0x80000000);


  static const Color panelBg = Color(0xFF2A1B3B); // inner panel background
  static const Color panelGradientStart = Color(0xFF281435);
  static const Color panelGradientEnd = Color(0xFF361B4D);
  static const LinearGradient cardGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF059669), // dark slate grey
      Color(0xFF10B981),
      Color(0xFF34D399), // bluish grey
    ],
  );
}
