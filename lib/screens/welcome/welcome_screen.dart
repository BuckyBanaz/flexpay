import 'package:flex/constant/app_assets.dart';
import 'package:flex/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';
import '../../constant/app_colors.dart';
import '../../utils/gradient_scaffold.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // We want top spacing, then a centered middle block, then fixed bottom block
          children: [
            SizedBox(height: 3.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to\n',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 20.sp,
                    ),
                  ),
                  TextSpan(
                    text: 'Flex Pay',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Unlock the full potential of financial power to\n connect your account.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 1.h),

            Container(
              width: 100.w,
              height: 50.h,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppAssets.welcome),)
              ),
            ),
            Spacer(),
            // Bottom fixed block: CTA + security text
            Padding(
              padding: EdgeInsets.only(
                bottom: 3.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("Already have an account?  ",style: TextStyle(
                      color: AppColors.textSecondary
                    ),),
                      Text("Log in",style: TextStyle(
                          color: AppColors.primary,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: 50.w,
                    height: 6.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offNamed(AppRoutes.main);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Started',
                            style: TextStyle(
                             color: AppColors.textPrimary,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Icon(
                            Icons.arrow_forward,
                            size: 16.sp,
                            color: AppColors.textPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconlyLight.shield_done,
                        size: 3.9.w,
                        color: Colors.green,
                      ),
                      SizedBox(width: 1.w),
                      Flexible(
                        child: Text(
                          'Bank-level security. Your data is safe with us.',
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
