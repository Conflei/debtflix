import 'package:auto_route/auto_route.dart';
import 'package:debtflix/core/misc/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackModal extends StatefulWidget {
  const FeedbackModal({super.key});

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0;

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: 350.h + (isKeyboardVisible ? bottomInset * 1.6 : 0),
          color: Colors.green.withAlpha(0),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: isKeyboardVisible ? bottomInset : 0,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 380.w,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 166, 105, 240),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 335.h + (isKeyboardVisible ? bottomInset * 1.6 : 0),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 12.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Give us feedback",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkPurple,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          height: 140.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.grey.withAlpha(100),
                            ),
                          ),
                          child: TextFormField(
                            initialValue: '',
                            maxLines: 4,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(height: 30.h),
                        GestureDetector(
                          onTap: () {
                            context.router.pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: AppColors.purple,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
