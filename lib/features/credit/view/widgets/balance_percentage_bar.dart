import 'package:debtflix/core/misc/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalancePercentageBar extends StatelessWidget {
  final double percentage;
  const BalancePercentageBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 80.h,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  percentage < 30 ? "Excellent" : "",

                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightGreen,
                  ),
                ),
                Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen.withAlpha(
                      percentage < 30 ? 255 : 150,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.r),
                      bottomLeft: Radius.circular(6.r),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10.h,
                      child: VerticalDivider(
                        color: percentage < 10
                            ? AppColors.lightGreen
                            : AppColors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                      child: VerticalDivider(
                        color: (percentage < 30 && percentage > 10)
                            ? AppColors.lightGreen
                            : AppColors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0-9%',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: percentage < 10
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: percentage < 10
                            ? AppColors.lightGreen
                            : AppColors.grey,
                      ),
                    ),
                    Text(
                      '10-29%',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: (percentage < 30 && percentage > 10)
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: (percentage < 30 && percentage > 10)
                            ? AppColors.lightGreen
                            : AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (percentage < 50 && percentage > 30) ? "Good" : "",

                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.yellow,
                  ),
                ),
                Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: Colors.yellow.withAlpha(
                      (percentage < 50 && percentage > 30) ? 255 : 150,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                      child: VerticalDivider(
                        color: (percentage < 50 && percentage > 30)
                            ? Colors.yellow
                            : AppColors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '30-49%',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: (percentage < 50 && percentage > 30)
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: (percentage < 50 && percentage > 30)
                            ? Colors.yellow
                            : AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  percentage > 50 ? "Poor" : "",

                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(percentage > 50 ? 255 : 150),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6.r),
                      bottomRight: Radius.circular(6.r),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10.h,
                      child: VerticalDivider(
                        color: percentage < 75 && percentage > 50
                            ? Colors.red
                            : AppColors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                      child: VerticalDivider(
                        color: (percentage > 75) ? Colors.red : AppColors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '50-74%',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: percentage < 75 && percentage > 50
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: percentage < 75 && percentage > 50
                            ? Colors.red
                            : AppColors.grey,
                      ),
                    ),
                    Text(
                      '>75%',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: (percentage > 75)
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: (percentage > 75) ? Colors.red : AppColors.grey,
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
