import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/features/user/providers/user_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditScoreChart extends ConsumerWidget {
  const CreditScoreChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (user == null || user.creditData.prevScores.isEmpty) {
      return Container(
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: const Center(child: Text('No credit score data available')),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Text(
                  "Chart",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(color: Colors.grey.shade400, width: 1.w),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Credit Score",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.purpleTitle,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            child: Text(
                              "+2pts",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Updated Today | Next May 12",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.purpleTitleLight,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Experian",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.lightPurple,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 70.h,
                    width: double.infinity,
                    child: _buildChart(user.creditData.prevScores),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Last 12 Months",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade900,
                            ),
                          ),
                          Text(
                            "Score calculated using VantageScore 3.0",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<MapEntry<DateTime, int>> prevScores) {
    final sortedScores = List<MapEntry<DateTime, int>>.from(prevScores)
      ..sort((a, b) => a.key.compareTo(b.key));

    final today = DateTime.now();
    final twelveMonthsAgo = DateTime(today.year - 1, today.month, today.day);

    final filteredScores = sortedScores.where((entry) {
      return entry.key.isAfter(twelveMonthsAgo) ||
          entry.key.isAtSameMomentAs(twelveMonthsAgo);
    }).toList();

    if (filteredScores.isEmpty) {
      return Center(
        child: Text(
          'No credit score data in the last 12 months',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
        ),
      );
    }

    final scores = filteredScores.map((e) => e.value).toList();
    final minScore = scores.reduce((a, b) => a < b ? a : b);
    final maxScore = scores.reduce((a, b) => a > b ? a : b);

    final roundedMinScore = ((minScore / 50).floor() * 50).toDouble();
    final roundedMaxScore = ((maxScore / 50).ceil() * 50).toDouble();
    final middleScore = (roundedMinScore + roundedMaxScore) / 2;

    final spots = filteredScores.map((entry) {
      return FlSpot(
        entry.key.millisecondsSinceEpoch.toDouble(),
        entry.value.toDouble(),
      );
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 5,
          getDrawingHorizontalLine: (value) {
            if (value == roundedMinScore ||
                value == middleScore ||
                value == roundedMaxScore) {
              return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
            }
            return FlLine(color: Colors.grey.shade300, strokeWidth: 0);
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 30,
              interval:
                  (today.millisecondsSinceEpoch -
                      twelveMonthsAgo.millisecondsSinceEpoch) /
                  3,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (roundedMaxScore - roundedMinScore) / 2,
              getTitlesWidget: (value, meta) {
                final tolerance = 1.0;
                if ((value - roundedMinScore).abs() < tolerance ||
                    (value - middleScore).abs() < tolerance ||
                    (value - roundedMaxScore).abs() < tolerance) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
          border: Border.all(color: Colors.grey.shade300),
        ),
        minX: twelveMonthsAgo.millisecondsSinceEpoch.toDouble(),
        maxX: today.millisecondsSinceEpoch.toDouble(),
        minY: roundedMinScore - 1,
        maxY: roundedMaxScore + 1,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            gradient: LinearGradient(
              colors: [AppColors.lightGreen, AppColors.lightGreen],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: AppColors.lightGreen,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
