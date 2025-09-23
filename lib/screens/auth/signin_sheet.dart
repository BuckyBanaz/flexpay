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
    final radius = BorderRadius.circular(16.0);

    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.5,
      maxChildSize: 0.95,
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
                // top handle + title
                Center(
                  child: Container(
                    width: 48,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Welcome Back', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
                    GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.close)),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Sign in to your account', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 18),

                // Email
                Text('Email', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                GlassTextField(
                  controller: c.emailCtrl,
                  hint: 'Enter your email',
                  prefix: Icons.email_outlined,
                ),
                const SizedBox(height: 12),

                // Password
                Text('Password', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Obx(() => GlassTextField(
                  controller: c.passCtrl,
                  hint: 'Enter your password',
                  prefix: Icons.lock_outline,
                  obscure: !c.passwordVisible.value,
                  suffix: IconButton(
                    icon: Icon(c.passwordVisible.value ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
                    onPressed: () => c.passwordVisible.toggle(),
                  ),
                )),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Row(
                      children: [
                        Checkbox(value: c.rememberMe.value, onChanged: (v) => c.rememberMe.value = v ?? false),
                        const Text('Remember me', style: TextStyle(color: Colors.white70))
                      ],
                    )),
                    TextButton(onPressed: () {/* forgot */}, child: const Text('Forgot Password?', style: TextStyle(color: AppColors.primary))),
                  ],
                ),
                const SizedBox(height: 18),

                // Sign In Button
                Obx(() => SizedBox(
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
                        Text('Sign In', style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16.sp,
                    ),
                    ),
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: AppColors.textPrimary),
                      ],
                    ),
                  ),
                )),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?  ",
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
                          builder: (_) => const SignUpSheetWrapper(),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                LabeledDivider(label: 'Or continue with', pillColor: Color(0xFF0B0E14)),
                const SizedBox(height: 12),
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
