import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<Color> gradientColors;
  final VoidCallback onPressed;

  const AnimatedActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.gradientColors,
    required this.onPressed,
  });

  @override
  State<AnimatedActionButton> createState() => _AnimatedActionButtonState();
}

class _AnimatedActionButtonState extends State<AnimatedActionButton> {
  bool _pressed = false;

  void _handleTapDown(_) {
    setState(() => _pressed = true);
  }

  void _handleTapUp(_) {
    setState(() => _pressed = false);
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Column(
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 140),
            scale: _pressed ? 0.92 : 1.0,
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: _pressed
                    ? [
                  BoxShadow(
                    color: widget.gradientColors.last.withOpacity(0.32),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ]
                    : [
                  BoxShadow(
                    color: widget.gradientColors.last.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(widget.icon, color: Colors.white),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.label,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
