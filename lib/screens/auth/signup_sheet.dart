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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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
                    margin: const EdgeInsets.only(bottom: 12),
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
                      'Create Account',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Full name
                Text('Full Name', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                GlassTextField(
                  controller: c.nameCtrl,
                  hint: 'Enter your full name',
                  prefix: Icons.person_outline,
                ),
                const SizedBox(height: 12),

                // Email
                Text('Email', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                GlassTextField(
                  controller: c.emailCtrl,
                  hint: 'Enter your email',
                  prefix: Icons.email_outlined,
                ),
                const SizedBox(height: 12),

                // Phone
                Text('Phone Number', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                GlassTextField(
                  controller: c.phoneCtrl,
                  hint: 'Enter your phone number',
                  prefix: Icons.phone_outlined,
                ),
                const SizedBox(height: 12),

                // Password
                Text('Password', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Obx(
                  () => GlassTextField(
                    controller: c.passCtrl,
                    hint: 'Create a password',
                    prefix: Icons.lock_outline,
                    obscure: !c.passwordVisible.value,
                    suffix: IconButton(
                      icon: Icon(
                        c.passwordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white54,
                      ),
                      onPressed: () => c.passwordVisible.toggle(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Confirm Password
                Text(
                  'Confirm Password',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => GlassTextField(
                    controller: c.confirmPassCtrl,
                    hint: 'Confirm your password',
                    prefix: Icons.lock_outline,
                    obscure: !c.confirmPasswordVisible.value,
                    suffix: IconButton(
                      icon: Icon(
                        c.confirmPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                            children: [
                              const TextSpan(text: "I agree to the "),
                              TextSpan(
                                text: "Terms of Service",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: Open Terms of Service page
                                  },
                              ),
                              const TextSpan(text: " and "),
                              TextSpan(
                                text: "Privacy Policy",
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
                          ? const CircularProgressIndicator(
                              color: AppColors.textPrimary,
                            )
                          : Text(
                              'Create Account',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16.sp,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () {
                        // open signin sheet on top

                        Get.back(); // or Navigator.of(context).pop();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const SignInSheetWrapper(),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                LabeledDivider(label: 'Or sign up with'),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: GlassAuthButton(
                        onPressed: () {
                          // Google sign-in action
                        },
                        // try to use an asset if you have it
                        leading: (true)
                            ? Image.asset('assets/google.png', width: 20, height: 20, fit: BoxFit.contain)
                        // fallback: small colored 'G' circle
                            : Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                          child: const Center(child: Text('G', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
                        ),
                        label: 'Google',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GlassAuthButton(
                        onPressed: () {
                          // Apple sign-in action
                        },
                        // use built-in icon or asset
                        leading: Icon(Icons.apple, size: 20, color: Colors.white),
                        label: 'Apple',
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
