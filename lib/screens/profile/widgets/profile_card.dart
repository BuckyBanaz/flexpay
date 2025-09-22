import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/app_colors.dart';

// Replace this with your actual AppColors import
// import 'package:your_project/constant/app_colors.dart';

// Temporary fallback AppColors if you don't have the file yet.
// Remove this when you use your real AppColors.


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Example AppColors (replace with your real ones)

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.02),
                blurRadius: 0,
                spreadRadius: 0.5,
                offset: const Offset(-1, -1),
              ),

            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Image with Colored Ring + Badges
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Ring container
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 3.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.18),
                          blurRadius: 14,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: const NetworkImage(
                        "https://i.pravatar.cc/150?img=3",
                      ),
                    ),
                  ),

                  // Green check badge
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Icon(Icons.check, size: 16, color: Colors.white),
                    ),
                  ),

                  // Orange medal badge
                  Positioned(
                    right: -6,
                    bottom: -6,
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Icon(Icons.emoji_events, size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Name
              Text(
                "Sandy Chungus",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 6),

              // Premium Member
              Text(
                "Premium Member",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 6),

              // Member since
              Text(
                "Member since 2023",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 18),

              // Edit Profile Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  elevation: 6,
                  shadowColor: AppColors.primary.withOpacity(0.35),
                ),
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                label: Text(
                  "Edit Profile",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

