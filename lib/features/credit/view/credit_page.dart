import 'package:auto_route/auto_route.dart';
import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/router/app_router.gr.dart';
import 'package:debtflix/features/user/providers/user_providers.dart';
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
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user data available")),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        leading: IconButton(
          onPressed: () {
            context.router.push(const UserRoute());
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
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 140.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
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
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
            ),

            Container(
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.all(20.w),
              child: ListView.builder(
                itemCount: user.creditData.prevScores.length,
                itemBuilder: (context, index) {
                  final creditReport = user.creditData.prevScores[index];
                  return Text(
                    "Credit Score: ${creditReport.value} Date: ${creditReport.key}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),

            Container(
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.all(20.w),
              child: ListView.builder(
                itemCount: user.creditData.creditCardAccounts.length,
                itemBuilder: (context, index) {
                  final creditCardAccount =
                      user.creditData.creditCardAccounts[index];
                  return Text(creditCardAccount.name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
