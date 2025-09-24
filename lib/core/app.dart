// lib/core/app.dart
import 'package:flex/core/app_theme.dart';
import 'package:flex/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../services/app_translations.dart';
import '../services/locale_controller.dart';

class FlexWallet extends StatelessWidget {
  const FlexWallet({super.key});
  @override
  Widget build(BuildContext context) {
    final localeCtrl = Get.find<LocaleController>(); // put in main()

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'brand_name'.tr,
        theme: AppTheme.darkTheme,
        darkTheme:  AppTheme.darkTheme,
        translations: TranslationService(), // GetX translations
        locale: localeCtrl.current.value,
        fallbackLocale: TranslationService.defaultFallback,
        supportedLocales: TranslationService.supportedLocales,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: AppRoutes.welcome,
        getPages: AppRoutes.routes,
        defaultTransition: Transition.cupertino,
      );
    });
  }
}
