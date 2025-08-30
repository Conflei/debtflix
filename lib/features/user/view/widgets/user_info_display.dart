import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/misc/utils.dart';
import 'package:debtflix/features/user/providers/user_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoDisplay extends ConsumerWidget {
  final VoidCallback onEdit;
  final VoidCallback onConfirm;
  const UserInfoDisplay({
    super.key,
    required this.onEdit,
    required this.onConfirm,
  });

  String _formatEmploymentDuration(int years, int months) {
    final yearsText = years == 0
        ? ''
        : years == 1
        ? '1 year'
        : '$years years';

    final monthsText = months == 0
        ? ''
        : months == 1
        ? '1 month'
        : '$months months';

    return '$yearsText $monthsText'.trim();
  }

  String _formatNextPayDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sept',
        'Oct',
        'Nov',
        'Dec',
      ];

      String getDaySuffix(int day) {
        if (day >= 11 && day <= 13) return 'th';
        switch (day % 10) {
          case 1:
            return 'st';
          case 2:
            return 'nd';
          case 3:
            return 'rd';
          default:
            return 'th';
        }
      }

      const weekdays = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];

      final month = months[date.month - 1];
      final day = date.day;
      final daySuffix = getDaySuffix(day);
      final year = date.year;
      final weekday = weekdays[date.weekday - 1];

      return '$month $day$daySuffix, $year ($weekday)';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user data available")),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Confirm your employment",
                style: GoogleFonts.anton(
                  textStyle: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Please review and confirm the below employment details are up-to-date.",
                style: TextStyle(
                  fontSize: 16.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Employment type",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user.employmentData.employmentType.displayName,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Employer",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user.employmentData.employer,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Job Title",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user.employmentData.jobTitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Gross Annual Income",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                Utils.formatCurrency(user.employmentData.annualIncome),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Pay Frequency",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user.employmentData.payFrequency.displayName,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Employer Address",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user.employmentData.employerAddress,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Time with employer",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                _formatEmploymentDuration(
                  user.employmentData.yearsAtEmployer,
                  user.employmentData.monthsAtEmployer,
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Next Pay Date",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                _formatNextPayDate(user.employmentData.nextPayDate),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Direct Deposit",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user.employmentData.isDirectDeposit ? 'Yes' : 'No',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.purple, width: 2.w),
                  ),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.purple,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: onConfirm,
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
