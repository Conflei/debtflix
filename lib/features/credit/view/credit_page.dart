import 'package:auto_route/auto_route.dart';
import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/misc/constants.dart';
import 'package:debtflix/core/misc/utils.dart';
import 'package:debtflix/core/router/app_router.gr.dart';
import 'package:debtflix/data/models/credit_card_account.dart';
import 'package:debtflix/data/models/credit_data.dart';
import 'package:debtflix/data/models/employment_data.dart';
import 'package:debtflix/data/models/user.dart';
import 'package:debtflix/features/credit/view/widgets/account_details_widget.dart';
import 'package:debtflix/features/credit/view/widgets/circular_progress_widget.dart';
import 'package:debtflix/features/credit/view/widgets/credit_card_accounts_widget.dart';
import 'package:debtflix/features/credit/view/widgets/credit_factors_scroll.dart';
import 'package:debtflix/features/credit/view/widgets/feedback_modal.dart';
import 'package:debtflix/features/user/providers/user_providers.dart';
import 'package:debtflix/features/credit/view/widgets/credit_score_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreditPage extends ConsumerStatefulWidget {
  const CreditPage({super.key});

  @override
  ConsumerState<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends ConsumerState<CreditPage> {
  void waitAndShowFeedbackModal() async {
    final currentContext = context;

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: currentContext,
        builder: (context) => const FeedbackModal(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user data available")),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        leading: IconButton(
          onPressed: () {
            context.router.push(UserRoute(onConfirm: waitAndShowFeedbackModal));
          },
          icon: const Icon(Icons.settings, color: Colors.white),
        ),
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.background,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                  color: AppColors.purple,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                    left: 20.w,
                    right: 20.w,
                    bottom: 20.h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Credit Score",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGreen,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
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

                                Text(
                                  "Updated Today | Next May 12",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.purpleTitleLight,
                                  ),
                                ),
                                Text(
                                  "Experian",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.lightPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CircularProgressWidget(
                            title: user.creditData.prevScores.last.value
                                .toStringAsFixed(0),
                            subtitle: Utils.statusCreditScore(
                              user.creditData.prevScores.last.value,
                            ),
                            percent:
                                user.creditData.prevScores.last.value /
                                MAX_CREDIT_SCORE,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              CreditScoreChart(),

              SizedBox(height: 20.h),

              // // CreditFactorsScroll(),
              // SizedBox(height: 20.h),
              AccountDetailsWidget(),
              SizedBox(height: 20.h),
              CreditCardAccountsWidget(),
              SizedBox(height: 400.h),
            ],
          ),
        ),
      ),
    );
  }
}
