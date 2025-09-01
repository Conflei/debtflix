import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/misc/utils.dart';
import 'package:debtflix/features/user/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditCardAccountsWidget extends ConsumerWidget {
  const CreditCardAccountsWidget({super.key});

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
          Row(
            children: [
              Text(
                "Open credit card accounts",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(color: Colors.grey.shade400, width: 1.w),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: user.creditData.creditCardAccounts.length,
              itemBuilder: (context, index) {
                final creditCardAccount =
                    user.creditData.creditCardAccounts[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 0.0,
                  ),
                  child: Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              creditCardAccount.name,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.purpleTitle,
                              ),
                            ),
                            Text(
                              "${(creditCardAccount.balance / creditCardAccount.limit * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.purpleTitle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: double.infinity,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.easeOutCubic,
                            tween: Tween<double>(
                              begin: 0.0,
                              end:
                                  (creditCardAccount.balance /
                                          creditCardAccount.limit)
                                      .clamp(0.0, 1.0),
                            ),
                            builder: (context, value, child) {
                              return FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGreen,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${Utils.formatCurrency(creditCardAccount.balance)} Balance",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.purpleTitle,
                              ),
                            ),
                            Text(
                              "${Utils.formatCurrency(creditCardAccount.limit)} Limit",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.purpleTitle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text(
                              "Reported on ${Utils.formatDate(creditCardAccount.lastReported)}",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.purpleTitleLight,
                              ),
                            ),
                          ],
                        ),

                        if (index <
                            user.creditData.creditCardAccounts.length - 1)
                          Column(
                            children: [
                              SizedBox(height: 10.h),
                              Divider(),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
