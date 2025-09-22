import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsController extends GetxController {
  // 0 => Week, 1 => Month, 2 => Year
  final periodIndex = 0.obs;

  // 0 => Income, 1 => Outcome
  final incomeOutcomeIndex = 1.obs;

  // highlighted point index (Saturday example)
  final highlightedPointIndex = 5.obs;

  // Dummy data for week (7 days). replace with real data as needed
  final weekPoints = <double>[1200, 1800, 1500, 2200, 1700, 3500, 3000].obs;

  // convenience getter for FlSpots
  List<FlSpot> get weekSpots {
    return List.generate(weekPoints.length, (i) => FlSpot(i.toDouble(), weekPoints[i]));
  }

  // change period
  void setPeriod(int i) => periodIndex.value = i;

  // change Income/Outcome
  void setIncomeOutcome(int i) => incomeOutcomeIndex.value = i;

  // set highlighted index
  void setHighlightedIndex(int i) => highlightedPointIndex.value = i;
}
