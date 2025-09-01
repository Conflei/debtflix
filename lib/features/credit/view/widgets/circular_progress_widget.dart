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
    return CircularPercentIndicator(
      radius: 40.r,
      lineWidth: 7.w,
      percent: widget.percent,
      startAngle: 180,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.anton(
              textStyle: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w100,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            widget.subtitle,
            style: TextStyle(
              fontSize: 12.sp,
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
