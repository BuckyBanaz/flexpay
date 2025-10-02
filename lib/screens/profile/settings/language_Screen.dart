// lib/screens/settings/language_screen.dart
import 'package:flex/constant/app_colors.dart';
import 'package:flex/services/app_translations.dart';
import 'package:flex/services/locale_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleController lc = Get.find<LocaleController>();

    // Build a list of language "code" strings like 'en_US', 'ar_SA'
    final codes = TranslationService.supportedCodes;

    return Scaffold(
      appBar: AppBar(
        title: Text('language'.tr),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'choose_language'.tr,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 12),

              // Description
              Text(
                'language_screen_subtitle'.tr,
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 18),

              // List of languages (reactive)
              Obx(() {
                final currentCode = LocaleController.localeToCode(lc.current.value);

                return Card(
                  color: Colors.white.withOpacity(0.03),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(), // let outer scroll handle it
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      final code = codes[i];
                      final isSelected = code == currentCode;

                      // Friendly label (you can change codeToLabel to return localized labels if you want)
                      final label = LocaleController.codeToLabel(code);

                      final locale = TranslationService.localeFromCode(code);
                      final isRtl = Bidi.isRtlLanguage(locale.languageCode);

                      return ListTile(
                        onTap: () async {
                          // 1) compute a readable label (like "English" / "العربية")
                          final readableLabel = LocaleController.codeToLabel(code);

                          // 2) change & save locale
                          await lc.saveAndChange(code);

                          // 3) Build final message by taking the translated template and replacing {0}
                          //    We call .tr *after* changing locale so the template is in the new language.
                          final template = 'language_changed'.tr; // e.g. "Language changed to {0}"
                          final finalMessage = template.replaceAll('{0}', readableLabel);

                          // 4) Show snackbar with finalMessage (title). Empty message body.
                          Get.snackbar(
                            finalMessage,
                            '',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.black.withOpacity(0.6),
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(12),
                          );
                        },
                        leading: CircleAvatar(
                          // a small badge — you can replace with flag assets if you have them
                          backgroundColor: isSelected ? AppColors.primary : Colors.white10,
                          child: Text(label.isNotEmpty ? label[0] : '?', style: const TextStyle(color: Colors.white)),
                        ),
                        title: Text(label, style: TextStyle(fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500)),
                        subtitle: Text(
                          '${locale.languageCode}${locale.countryCode != null ? " - ${locale.countryCode}" : ""}',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check, color: AppColors.primary)
                            : (isRtl ? const Text('RTL', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w600)) : null),
                        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(height: 0.5, color: Colors.white12),
                    itemCount: codes.length,
                  ),
                );
              }),

              const SizedBox(height: 18),

              // Optional explanatory note for RTL
              Obx(() {
                final isRtlNow = lc.isCurrentRTL;
                return Visibility(
                  visible: isRtlNow,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.04)),
                    ),
                    child: Text(
                      'rtl_note'.tr,
                      style: const TextStyle(color: Colors.white70),
                      textAlign: TextAlign.start,
                    ),
                  ),
                );
              }),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Return to previous screen
                    Navigator.maybePop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('done'.tr, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
