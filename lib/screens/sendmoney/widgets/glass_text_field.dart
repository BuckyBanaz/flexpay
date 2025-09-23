import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';
class GlassTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final Widget? prefixIcon;
  final double borderRadius;
  final double blurSigma;
  final EdgeInsetsGeometry padding;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  const GlassTextField({
    Key? key,
    this.controller,
    this.hint = '',
    this.prefixIcon,
    this.borderRadius = 14.0,
    this.blurSigma = 10.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    this.onChanged,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          // Back layer — you can remove/change gradient if you already have background image
          Container(
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.scaffold.withOpacity(0.36),
                  AppColors.scaffold.withOpacity(0.20),
                ],
              ),
            ),
          ),

          // Blur + glass overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              height: 52,
              padding: padding,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.02), // frosted tint
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: Colors.white.withOpacity(0.04)),

              ),
              child: Row(
                children: [
                  if (prefixIcon != null) ...[
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        
                      ),
                      child: Center(child: prefixIcon),
                    ),
                    SizedBox(width: 10),
                  ],

                  // TextField
                  Expanded(
                    child: TextField(
                      controller: controller,
                      obscureText: obscureText,
                      onChanged: onChanged,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                      cursorColor: AppColors.primary,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        isDense: true,
                        hintText: hint,
                        hintStyle: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13.5,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


