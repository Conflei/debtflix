import 'package:debtflix/core/misc/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularProgressWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final double percent;
  const CircularProgressWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.percent,
  });

  @override
  State<CircularProgressWidget> createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget> {
  @override
  Widget build(BuildContext context) {
    // Calculate responsive font sizes based on available space
    final radius = 40.r;
    final availableHeight = radius * 1.6; // Use 80% of diameter for text
    final titleFontSize = (availableHeight * 0.4).clamp(
      16.0,
      26.0,
    ); // Min 16, Max 26
    final subtitleFontSize = (availableHeight * 0.2).clamp(
      8.0,
      12.0,
    ); // Min 8, Max 12

    return CircularPercentIndicator(
      radius: radius,
      lineWidth: 7.w,
      percent: widget.percent,
      startAngle: 180,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.anton(
              textStyle: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w100,
                color: Colors.black,
              ),
            ),
          ),

          Text(
            widget.subtitle,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: subtitleFontSize,
              fontWeight: FontWeight.w600,
              color: AppColors.purpleTitle,
            ),
          ),
        ],
      ),
      progressColor: AppColors.lightGreen,
    );
  }
}
