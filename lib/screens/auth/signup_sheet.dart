import 'package:flex/constant/app_colors.dart';
import 'package:flex/screens/auth/signin_sheet.dart';
import 'package:flex/screens/auth/widgets/glass_effect_auth_button.dart';
import 'package:flex/screens/auth/widgets/glass_effect_textfield.dart';
import 'package:flex/screens/auth/widgets/labeled_divider.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../modules/auth/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpSheet extends StatelessWidget {
  const SignUpSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController c = Get.put(AuthController());
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.6,
      maxChildSize: 0.98,
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
                Center(
                  child: Container(
                    width: 48,
                    height: 4,
                    margin: const EdgeInsetsDirectional.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'create_account'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Full name
                Text('full_name'.tr, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                GlassTextField(
                  controller: c.nameCtrl,
                  hint: 'enter_full_name'.tr,
                  prefix: Icons.person_outline,
                ),
                const SizedBox(height: 12),

                // Email
                Text('email'.tr, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                GlassTextField(
                  controller: c.emailCtrl,
                  hint: 'enter_email'.tr,
                  prefix: Icons.email_outlined,
                ),
                const SizedBox(height: 12),

                // Phone
                Text('phone_number'.tr, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                GlassTextField(
                  controller: c.phoneCtrl,
                  hint: 'enter_phone'.tr,
                  prefix: Icons.phone_outlined,
                ),
                const SizedBox(height: 12),

                // Password
                Text('password'.tr, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Obx(
                      () => GlassTextField(
                    controller: c.passCtrl,
                    hint: 'create_password'.tr,
                    prefix: Icons.lock_outline,
                    obscure: !c.passwordVisible.value,
                    suffix: IconButton(
                      icon: Icon(
                        c.passwordVisible.value ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white54,
                      ),
                      onPressed: () => c.passwordVisible.toggle(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Confirm Password
                Text('confirm_password'.tr, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Obx(
                      () => GlassTextField(
                    controller: c.confirmPassCtrl,
                    hint: 'confirm_password_hint'.tr,
                    prefix: Icons.lock_outline,
                    obscure: !c.confirmPasswordVisible.value,
                    suffix: IconButton(
                      icon: Icon(
                        c.confirmPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white54,
                      ),
                      onPressed: () => c.confirmPasswordVisible.toggle(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Obx(
                      () => Row(
                    children: [
                      Checkbox(
                        value: c.agreeTos.value,
                        onChanged: (v) => c.agreeTos.value = v ?? false,
                        activeColor: AppColors.primary,
                      ),
                      Flexible(
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(text: 'i_agree'.tr + ' '),
                              TextSpan(
                                text: 'terms_of_service'.tr,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: Open Terms of Service page
                                  },
                              ),
                              TextSpan(text: ' ' + 'and'.tr + ' '),
                              TextSpan(
                                text: 'privacy_policy'.tr,
                                style: TextStyle(color: AppColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: Open Privacy Policy page
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: c.loading.value ? null : () => c.signUp(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: c.loading.value
                          ? const CircularProgressIndicator(color: AppColors.textPrimary)
                          : Text(
                        'create_account'.tr,
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already_have_account'.tr + ' ', style: TextStyle(color: Colors.white70)),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const SignInSheetWrapper(),
                        );
                      },
                      child: Text('sign_in'.tr, style: const TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
                LabeledDivider(label: 'or_sign_up_with'.tr),
                const SizedBox(height: 14),
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
              ],
            ),
          ),
        );
      },
    );
  }
}

// wrapper used to avoid circular import
class SignInSheetWrapper extends StatelessWidget {
  const SignInSheetWrapper({super.key});
  @override
  Widget build(BuildContext context) => const SignInSheet();
}
