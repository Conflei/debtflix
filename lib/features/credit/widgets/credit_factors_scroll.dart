import 'package:debtflix/core/misc/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditFactorsScroll extends StatelessWidget {
  CreditFactorsScroll({super.key});

  // This items are static for now, they could be made more complex later by adding an
  // specific class that will handle the logic on what is high impact or low impact for which
  // factor and also the logic for the color of the impact.
  // For now, we will just have a static list of items.
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Payment History',
      'value': "100%",
      'impact': "HIGH IMPACT",
      'buttonColor': Colors.green.shade900,
      'buttonTextColor': Colors.white,
    },
    {
      'title': 'Credit Utilization',
      'value': "100%",
      'impact': "MEDIUM IMPACT",
      'buttonColor': Colors.green.shade400,
      'buttonTextColor': Colors.white,
    },
    {
      'title': 'Derogatory Marks',
      'value': "350",
      'impact': "LOW IMPACT",
      'buttonColor': Colors.green.shade200,
      'buttonTextColor': Colors.black,
    },
    {
      'title': 'AVA\n Job',
      'value': "1",
      'impact': "HIGH IMPACT",
      'buttonColor': AppColors.purple,
      'buttonTextColor': Colors.white,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              Text(
                "Credit Factors",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 160.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 30.w),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return Container(
                width: 150.w,
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.grey.shade400, width: 1.w),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Value
                      Text(
                        item['value'],
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.purple,
                        ),
                      ),
                      Spacer(),

                      // Impact
                      Container(
                        width: 120.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: item['buttonColor'],
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Center(
                          child: Text(
                            item['impact'],
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: item['buttonTextColor'],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
