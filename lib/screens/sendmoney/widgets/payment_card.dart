import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/app_assets.dart';

class PaymentCard extends StatelessWidget {
  final bool selected;
  final Gradient gradient;
  final String cardNumber;
  final String holderName;
  final double balance;

  const PaymentCard({
    super.key,
    required this.selected,
    required this.gradient,
    required this.cardNumber,
    required this.holderName,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 18,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Stack(
        children: [
          // subtle inner dark overlay to get glassy contrast
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.06), Colors.black.withOpacity(0.02)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top row: chip + selected indicator
                Row(
                  children: [
                    // chip
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(AppAssets.chip)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const Spacer(),
                    // three circles indicator like image
                    Row(
                      children: [
                        Container(height: 8, width: 8, decoration: BoxDecoration(color: Colors.white24, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Container(height: 8, width: 8, decoration: BoxDecoration(color: Colors.white24, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Container(height: 8, width: 8, decoration: BoxDecoration(color: Colors.white24, shape: BoxShape.circle)),
                        const SizedBox(width: 10),
                        // selected tick
                        if (selected)
                          Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.25),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: const Icon(Icons.check_circle, color: Colors.white, size: 18),
                          ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                // card number
                Text(
                  cardNumber,
                  style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.95), fontSize: 16, letterSpacing: 2, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                // bottom row: holder name, balance and visa
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(holderName, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 6),
                        Text('\$${balance.toStringAsFixed(2)}', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const Spacer(),
                    // VISA badge (simple circular)
                    Container(
                      height: 46,
                      width: 68,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(AppAssets.visaCard)),

                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('VISA', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}