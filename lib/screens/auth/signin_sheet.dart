// lib/screens/auth/signin_sheet.dart
import 'dart:ui';
import 'package:flex/constant/app_colors.dart';
import 'package:flex/screens/auth/signup_sheet.dart';
import 'package:flex/screens/auth/widgets/glass_effect_auth_button.dart';
import 'package:flex/screens/auth/widgets/glass_effect_textfield.dart';
import 'package:flex/screens/auth/widgets/labeled_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../modules/auth/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInSheet extends StatelessWidget {
  const SignInSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController c = Get.put(AuthController());

    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controllerScroll) {
        return Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF151229),
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: SingleChildScrollView(
            controller: controllerScroll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top handle + title
                Center(
                  child: Container(
                    width: 48,
                    height: 4,
                    margin: const EdgeInsetsDirectional.only(bottom: 12),
                    decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('welcome_back'.tr,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start),
                    GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.close)),
                  ],
                ),
                const SizedBox(height: 12),
                Text('sign_in_to_account'.tr, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 18),

                // Email
                Text('email'.tr, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                GlassTextField(
                  controller: c.emailCtrl,
                  hint: 'enter_email'.tr,
                  prefix: Icons.email_outlined,
                ),
                const SizedBox(height: 12),

                // Password
                Text('password'.tr, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Obx(
                      () => GlassTextField(
                    controller: c.passCtrl,
                    hint: 'enter_password'.tr,
                    prefix: Icons.lock_outline,
                    obscure: !c.passwordVisible.value,
                    suffix: IconButton(
                      icon: Icon(c.passwordVisible.value ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
                      onPressed: () => c.passwordVisible.toggle(),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                          () => Row(
                        children: [
                          Checkbox(
                            value: c.rememberMe.value,
                            onChanged: (v) => c.rememberMe.value = v ?? false,
                            activeColor: AppColors.primary,
                          ),
                          Text('remember_me'.tr, style: TextStyle(color: Colors.white70))
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password flow
                      },
                      child: Text('forgot_password'.tr, style: const TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Sign In Button
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: c.loading.value ? null : () => c.signIn(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF13E0E9),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: c.loading.value
                          ? const CircularProgressIndicator(color: AppColors.textPrimary)
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'sign_in'.tr,
                            style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: AppColors.textPrimary),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("dont_have_account".tr + ' ', style: TextStyle(color: Colors.white70)),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const SignUpSheetWrapper(),
                        );
                      },
                      child: Text('sign_up'.tr, style: const TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
                LabeledDivider(label: 'or_continue_with'.tr, pillColor: const Color(0xFF0B0E14)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GlassAuthButton(
                        onPressed: () {
                          // Google sign-in action
                        },
                        leading: Image.asset('assets/google.png', width: 20, height: 20, fit: BoxFit.contain),
                        label: 'google'.tr,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GlassAuthButton(
                        onPressed: () {
                          // Apple sign-in action
                        },
                        leading: Icon(Icons.apple, size: 20, color: Colors.white),
                        label: 'apple'.tr,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        );
      },
    );
  }
}

// tiny wrapper to resolve circular import in SignInSheet -> SignUpSheet
class SignUpSheetWrapper extends StatelessWidget {
  const SignUpSheetWrapper({super.key});
  @override
  Widget build(BuildContext context) => const SignUpSheet();
}
