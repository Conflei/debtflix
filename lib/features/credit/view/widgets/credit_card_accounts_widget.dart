import 'package:debtflix/core/misc/app_colors.dart';
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(
                "Open credit card accounts",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
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
                  padding: const EdgeInsets.all(8.0),
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
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(creditCardAccount.balance / creditCardAccount.limit * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          width: double.infinity,
                          height: 4.h,
                          decoration: BoxDecoration(color: AppColors.purple),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${creditCardAccount.balance.toString()} Balance",
                            ),
                            Text("${creditCardAccount.limit.toString()} Limit"),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Reported on ${creditCardAccount.lastReported.toString()}",
                        ),
                        if (index <
                            user.creditData.creditCardAccounts.length - 1)
                          Divider(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
