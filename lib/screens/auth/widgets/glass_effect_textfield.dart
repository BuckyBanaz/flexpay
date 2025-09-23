import 'dart:ui';
import 'package:flutter/material.dart';

/// Reusable glassmorphic text field
class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final IconData? prefix;
  final Widget? suffix;
  final bool obscure;

  const GlassTextField({
    super.key,
    required this.controller,
    this.hint,
    this.prefix,
    this.suffix,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.03),
                Colors.white.withOpacity(0.01),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.white.withOpacity(0.06)),
            boxShadow: [
              BoxShadow(color: Colors.white.withOpacity(0.01), blurRadius: 2, spreadRadius: -2),
            ],
          ),
          child: Row(
            children: [
              if (prefix != null) ...[
                Icon(prefix, color: Colors.white54),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscure,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.45)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: 6),
                suffix!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
