import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../modules/stats/stats_controller.dart';


class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StatsController c = Get.put(StatsController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
          child: Column(
            children: [
              // Top row
              Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Statistics',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.more_vert, color: Colors.white70),
                ],
              ),

              const SizedBox(height: 18),

              // Period pills
              Obx(() {
                int periodIndex = c.periodIndex.value;
                final labels = ['Week', 'Month', 'Year'];
                return Container(
                  height: 40,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: List.generate(3, (i) {
                      final selected = periodIndex == i;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => c.setPeriod(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selected ? const Color(0xFF12E1E8) : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              labels[i],
                              style: GoogleFonts.poppins(
                                color: selected ? Colors.black : Colors.white70,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),

              const SizedBox(height: 22),

              // Total Spendings
              Column(
                children: [
                  Text(
                    'Total Spendings',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$15,500',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Income/Outcome tab with indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(() {
                  int io = c.incomeOutcomeIndex.value;
                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => c.setIncomeOutcome(0),
                          child: Column(
                            children: [
                              Text('Income',
                                  style: GoogleFonts.poppins(
                                      color: io == 0 ? Colors.white : Colors.white70)),
                              const SizedBox(height: 8),
                              Container(height: 4),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => c.setIncomeOutcome(1),
                          child: Column(
                            children: [
                              Text('Outcome',
                                  style: GoogleFonts.poppins(
                                      color: io == 1 ? Colors.white : Colors.white70)),
                              const SizedBox(height: 8),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  gradient: io == 1
                                      ? const LinearGradient(colors: [
                                    Color(0xFF00E5FF),
                                    Color(0xFF00B4FF)
                                  ])
                                      : null,
                                  color: io == 0 ? const Color(0xFF00E5FF) : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 18),

              // Chart area (Stack so we can overlay bubble & chip)
              Expanded(
                child: LayoutBuilder(builder: (context, constraints) {
                  final chartHeight = constraints.maxHeight * 0.78;
                  final chartWidth = constraints.maxWidth;
                  return Stack(
                    children: [
                      // Card-ish background with blur/glass effect behind chart
                      Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.03)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Overview',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white70, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              // Chart container
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
                                  child: Obx(() {
                                    final spots = c.weekSpots;
                                    final minY = (spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) * 0.9)
                                        .floorToDouble();
                                    final maxY = (spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.1)
                                        .ceilToDouble();

                                    return LineChart(
                                      LineChartData(
                                        minX: 0,
                                        maxX: (spots.length - 1).toDouble(),
                                        minY: minY,
                                        maxY: maxY,
                                        gridData: FlGridData(
                                          show: true,
                                          drawVerticalLine: false,
                                          horizontalInterval: (maxY - minY) / 4,
                                          getDrawingHorizontalLine: (value) => FlLine(
                                            color: Colors.white.withOpacity(0.03),
                                            strokeWidth: 1,
                                          ),
                                        ),
                                        titlesData: FlTitlesData(
                                          show: true,
                                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(showTitles: true, reservedSize: 30, getTitlesWidget: (value, meta) {
                                              const labels = ['Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'Mon'];
                                              int idx = value.toInt();
                                              if (idx >= 0 && idx < labels.length) {
                                                return Text(labels[idx], style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11));
                                              }
                                              return const SizedBox.shrink();
                                            }),
                                          ),
                                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        ),
                                        borderData: FlBorderData(show: false),
                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: spots,
                                            isCurved: true,
                                            curveSmoothness: 0.6,
                                            preventCurveOverShooting: true,
                                            // gradient is enough — no colorStops for this fl_chart version
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFF00E5FF), Color(0xFF00B4FF)],
                                            ),
                                            barWidth: 3,
                                            dotData: FlDotData(
                                              show: true,
                                              getDotPainter: (spot, percent, bar, index) {
                                                if (index == c.highlightedPointIndex.value) {
                                                  return FlDotCirclePainter(radius: 6, color: Colors.white, strokeWidth: 2, strokeColor: Color(0xFF00E5FF));
                                                }
                                                return FlDotCirclePainter(radius: 3.2, color: Color(0xFF00E5FF).withOpacity(0.9));
                                              },
                                            ),
                                            belowBarData: BarAreaData(
                                              show: true,
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  const Color(0xFF00E5FF).withOpacity(0.25),
                                                  const Color(0xFF00B4FF).withOpacity(0.06),
                                                ],
                                              ),
                                              cutOffY: double.infinity,
                                            ),
                                          ),
                                        ],
                                        lineTouchData: LineTouchData(
                                          enabled: true,
                                          touchCallback: (FlTouchEvent event, LineTouchResponse? resp) {
                                            // when user taps a point, update highlighted index
                                            if (resp != null && resp.lineBarSpots != null && resp.lineBarSpots!.isNotEmpty) {
                                              final idx = resp.lineBarSpots!.first.spotIndex;
                                              c.setHighlightedIndex(idx);
                                            }
                                          },
                                          handleBuiltInTouches: true,
                                          getTouchedSpotIndicator: (barData, indexes) {
                                            return indexes.map((i) {
                                              return TouchedSpotIndicatorData(
                                                FlLine(color: Colors.white.withOpacity(0.08), strokeWidth: 1),
                                                FlDotData(show: false),
                                              );
                                            }).toList();
                                          },
                                          touchTooltipData: LineTouchTooltipData(
                                            // not using built-in tooltip background; we overlay our own bubble
                                            tooltipBorderRadius: BorderRadius.circular(8),
                                            getTooltipItems: (spots) {
                                              return spots.map((s) => LineTooltipItem('', const TextStyle())).toList();
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // bottom labels row spacing (already handled by chart bottom titles)
                            ],
                          ),
                        ),
                      ),

                      // Overlay bubble & value chip using approximate position based on data (works well)
                      // We compute the position by mapping index -> relative x and value -> relative y
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
                          child: Obx(() {
                            final spots = c.weekSpots;
                            final idx = c.highlightedPointIndex.value.clamp(0, spots.length - 1);
                            final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) * 0.9;
                            final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.1;

                            // safe-size for calculation
                            final usableWidth = (chartWidth - 36); // account for padding
                            final usableHeight = (chartHeight - 70).clamp(60.0, chartHeight);

                            // normalized positions
                            final xPercentage = idx / (spots.length - 1);
                            final yPercentage = (spots[idx].y - minY) / (maxY - minY);
                            final xPos = 18 + xPercentage * usableWidth;
                            // chart's y grows downward on screen, but yPercentage higher means higher value -> lower y coordinate on screen
                            final yPos = 24 + (1 - yPercentage) * usableHeight;

                            // Prevent overflow
                            final bubbleLeft = (xPos - 120).clamp(6.0, chartWidth - 140);
                            final bubbleTop = (yPos - 76).clamp(6.0, chartHeight - 110);

                            return Stack(
                              children: [
                                // tip circle + connecting vertical dotted line (like image)
                                Positioned(
                                  left: xPos - 18,
                                  top: yPos - 18,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.2),
                                          border: Border.all(color: Colors.white24),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF00E5FF).withOpacity(0.2),
                                              blurRadius: 18,
                                              spreadRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // tooltip bubble
                                Positioned(
                                  left: bubbleLeft,
                                  top: bubbleTop,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // bubble
                                      Container(
                                        constraints: const BoxConstraints(maxWidth: 220),
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.06),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Colors.white.withOpacity(0.06)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.4),
                                              blurRadius: 10,
                                              offset: const Offset(0, 6),
                                            )
                                          ],
                                        ),
                                        child: Text(
                                          'Your spending decreased from 5% the last week.\nGood job!',
                                          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // value chip
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.45),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          '\$${spots[idx].y.toInt()}',
                                          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
