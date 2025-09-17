import 'package:flex/core/app_theme.dart';
import 'package:flex/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexWallet extends StatelessWidget {
  const FlexWallet({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex Pay',
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.routes,
      defaultTransition: Transition.cupertino,
    );
  }
}
