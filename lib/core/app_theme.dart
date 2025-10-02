// lib/core/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';

class AppTheme {
  // Legacy single darkTheme kept for quick usages
  static ThemeData darkTheme = themeFor(Locale('en', 'US'));

  /// Returns a ThemeData tuned for the provided [locale].
  /// - Arabic (locale.languageCode == 'ar') uses Tajawal
  /// - All other locales use Poppins
  static ThemeData themeFor(Locale locale) {
    final isArabic = locale.languageCode.toLowerCase().startsWith('ar');

    final baseTextTheme = isArabic
        ? GoogleFonts.tajawalTextTheme()
        : GoogleFonts.poppinsTextTheme();

    // Apply our color overrides
    final textTheme = baseTextTheme.apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.scaffold,
      primaryColor: AppColors.primary,
      textTheme: textTheme,
      // apply same font family for primary text styles for convenience
      primaryTextTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: (isArabic
            ? GoogleFonts.tajawal(textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ))
            : GoogleFonts.poppins(textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        )))
            .copyWith(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.scaffold,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
      ),
    );
  }

  /// Convenience: returns theme for current Get.locale if available, otherwise default
  static ThemeData get currentTheme {
    final loc = Get.locale ?? const Locale('en', 'US');
    return themeFor(loc);
  }
}
