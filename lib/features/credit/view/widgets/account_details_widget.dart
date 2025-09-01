import 'dart:math' as math;

import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/misc/utils.dart';
import 'package:debtflix/data/models/credit_card_account.dart';
import 'package:debtflix/features/credit/view/widgets/balance_percentage_bar.dart';
import 'package:debtflix/features/credit/view/widgets/circular_progress_widget.dart';
import 'package:debtflix/features/user/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountDetailsWidget extends ConsumerWidget {
  const AccountDetailsWidget({super.key});

  int _calculateTotalBalance(List<CreditCardAccount> creditCardAccounts) {
    return creditCardAccounts.fold(0, (sum, account) => sum + account.balance);
  }

  int _calculateTotalLimit(List<CreditCardAccount> creditCardAccounts) {
    return creditCardAccounts.fold(0, (sum, account) => sum + account.limit);
  }

  Widget _spentLimitWidget(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return Container();
    }

    return SizedBox(
      width: double.infinity,

      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeOutCubic,
        tween: Tween<double>(
          begin: 0.0,
          end:
              (user.creditData.spendLimit / user.creditData.avaCreditCard.limit)
                  .clamp(0.0, 1.0),
        ),
        builder: (context, value, child) {
          return FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value * 1,
            child: Container(
              alignment: Alignment.topRight,

              child: Transform.translate(
                offset: Offset(22.5.w, 0),
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  color: Colors.transparent,

                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        bottom: 15,
                        child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Container(
                            width: 15.w,
                            height: 15.h,
                            decoration: BoxDecoration(color: AppColors.purple),
                          ),
                        ),
                      ),
                      Container(
                        width: 40.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                          child: Text(
                            Utils.formatCurrency(user.creditData.spendLimit),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return Container(
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: const Center(child: Text('No credit score data available')),
      );
    }

    final totalBalance = _calculateTotalBalance(
      user.creditData.creditCardAccounts,
    );
    final totalLimit = _calculateTotalLimit(user.creditData.creditCardAccounts);

    final utilizationPercent = totalLimit == 0
        ? 0.0
        : (totalBalance / totalLimit) * 100.0;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Text(
                  "Account Details",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: Colors.grey.shade400, width: 1.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _spentLimitWidget(context, ref),

                    Container(
                      width: double.infinity,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: AppColors.paleGreen,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeOutCubic,
                        tween: Tween<double>(
                          begin: 0.0,
                          end:
                              (user.creditData.spendLimit /
                                      user.creditData.avaCreditCard.limit)
                                  .clamp(0.0, 1.0),
                        ),
                        builder: (context, value, child) {
                          return FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: value,
                            child: Container(
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Container(
                                width: 5.w,
                                decoration: BoxDecoration(
                                  color: AppColors.darkGreen,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8.h),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "Spend limit: \$${user.creditData.spendLimit} ",
                          ),
                          TextSpan(
                            text: "Why is this different?",
                            style: TextStyle(
                              color: AppColors.lightPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Utils.formatCurrency(
                                user.creditData.avaCreditCard.balance,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: AppColors.purpleTitle,
                              ),
                            ),
                            Text(
                              "Balance",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.purpleTitle,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              Utils.formatCurrency(
                                user.creditData.avaCreditCard.limit,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: AppColors.purpleTitle,
                              ),
                            ),
                            Text(
                              "Credit Limit",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.purpleTitle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Utilization",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.purpleTitle,
                          ),
                        ),
                        Text(
                          "${((user.creditData.avaCreditCard.balance / user.creditData.avaCreditCard.limit) * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: Colors.grey.shade400, width: 1.w),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Balance: ${Utils.formatCurrency(_calculateTotalBalance(user.creditData.creditCardAccounts))}",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Total limit: ${Utils.formatCurrency(_calculateTotalLimit(user.creditData.creditCardAccounts))}",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CircularProgressWidget(
                            title: '${utilizationPercent.toStringAsFixed(0)}%',

                            subtitle: Utils.utilizationStatus(
                              utilizationPercent,
                            ),

                            percent: utilizationPercent / 100,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    BalancePercentageBar(percentage: utilizationPercent),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
