import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../user/providers/user_providers.dart';

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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(
                "Chart",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          height: 300.h,
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
                Text(
                  'Credit Score History',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(child: _buildChart(user.creditData.prevScores)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChart(List<MapEntry<DateTime, int>> prevScores) {
    // Sort scores by date (oldest to newest)
    final sortedScores = List<MapEntry<DateTime, int>>.from(prevScores)
      ..sort((a, b) => a.key.compareTo(b.key));

    return CustomPaint(
      size: Size.infinite,
      painter: CreditScoreChartPainter(sortedScores),
    );
  }
}

class CreditScoreChartPainter extends CustomPainter {
  final List<MapEntry<DateTime, int>> scores;

  CreditScoreChartPainter(this.scores);

  @override
  void paint(Canvas canvas, Size size) {
    if (scores.isEmpty) return;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Calculate min and max scores for scaling
    final minScore = scores.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final maxScore = scores.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final scoreRange = maxScore - minScore;

    // Calculate date range for x-axis scaling
    final minDate = scores.first.key;
    final maxDate = scores.last.key;
    final dateRange = maxDate.difference(minDate).inDays;

    for (int i = 0; i < scores.length; i++) {
      final score = scores[i];
      final normalizedScore = scoreRange > 0
          ? (score.value - minScore) / scoreRange
          : 0.5;
      final normalizedDate = dateRange > 0
          ? score.key.difference(minDate).inDays / dateRange
          : 0.5;

      final x = normalizedDate * size.width;
      final y = size.height - (normalizedScore * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
