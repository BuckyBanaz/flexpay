// lib/main.dart
import 'package:flex/services/app_translations.dart';
import 'package:flex/services/locale_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'core/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Load translation JSONs
  await TranslationService.init();

  // 2) Put locale controller and apply saved locale (so app starts with right locale)
  final localeCtrl = Get.put(LocaleController());
  await localeCtrl.init();

  // 3) Run app
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return const FlexWallet();
      },
    ),
  );
}
