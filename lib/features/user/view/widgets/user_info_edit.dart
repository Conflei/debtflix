import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/misc/utils.dart';
import 'package:debtflix/data/models/employment_data.dart';
import 'package:debtflix/features/user/providers/user_providers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoEdit extends ConsumerStatefulWidget {
  final VoidCallback onSave;
  const UserInfoEdit({super.key, required this.onSave});

  @override
  ConsumerState<UserInfoEdit> createState() => _UserInfoEditState();
}

class _UserInfoEditState extends ConsumerState<UserInfoEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _annualIncomeController;

  @override
  void initState() {
    super.initState();
    _annualIncomeController = TextEditingController();
  }

  @override
  void dispose() {
    _annualIncomeController.dispose();
    super.dispose();
  }

  void _save() async {
    await ref.read(userProvider.notifier).saveUser();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User data updated successfully!")),
    );
    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    if (user != null && _annualIncomeController.text.isEmpty) {
      _annualIncomeController.text = Utils.formatCurrency(
        user.employmentData.annualIncome,
      );
    }

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user data available")),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background),
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside
          final currentUser = ref.read(userProvider);
          if (currentUser != null) {
            _annualIncomeController.text = Utils.formatCurrency(
              currentUser.employmentData.annualIncome,
            );
          }
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Text(
                      "Edit employment information",
                      style: GoogleFonts.anton(
                        textStyle: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w100,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Employment type",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.grey.withAlpha(100),
                          ),
                        ),
                        child: DropdownButtonFormField<EmploymentType>(
                          initialValue: user.employmentData.employmentType,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.sp),
                          icon: Icon(Icons.keyboard_arrow_down, size: 20),
                          isExpanded: false,
                          menuMaxHeight: 200,

                          items: EmploymentType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(
                                type.displayName,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.grey,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(userProvider.notifier)
                                  .updateEmploymentType(value);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Employer",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.grey.withAlpha(100),
                          ),
                        ),
                        child: TextFormField(
                          initialValue: user.employmentData.employer,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            ref
                                .read(userProvider.notifier)
                                .updateEmployer(value);
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Job Title",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.grey.withAlpha(100),
                          ),
                        ),
                        child: TextFormField(
                          initialValue: user.employmentData.jobTitle,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            ref
                                .read(userProvider.notifier)
                                .updateJobTitle(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Gross annual income",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.grey.withAlpha(100),
                          ),
                        ),
                        child: TextFormField(
                          controller: _annualIncomeController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: false,
                          ),
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            final cleanValue = value.replaceAll(
                              RegExp(r'[^\d]'),
                              '',
                            );
                            if (cleanValue.isNotEmpty) {
                              final income = int.parse(cleanValue);
                              ref
                                  .read(userProvider.notifier)
                                  .updateAnnualIncome(income);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Pay frequency",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.grey.withAlpha(100),
                          ),
                        ),
                        child: DropdownButtonFormField<PayFrequency>(
                          initialValue: user.employmentData.payFrequency,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.sp),
                          icon: Icon(Icons.keyboard_arrow_down, size: 20),
                          isExpanded: false,
                          menuMaxHeight: 200,

                          items: PayFrequency.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(
                                type.displayName,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.grey,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(userProvider.notifier)
                                  .updatePayFrequency(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "My next payday is",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.grey.withAlpha(100),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.tryParse(
                                    user.employmentData.nextPayDate,
                                  ) ??
                                  DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (pickedDate != null) {
                              ref
                                  .read(userProvider.notifier)
                                  .updateNextPayDate(
                                    pickedDate.toIso8601String(),
                                  );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user.employmentData.nextPayDate.isNotEmpty
                                      ? Utils.formatNextPayDate(
                                          user.employmentData.nextPayDate,
                                        )
                                      : 'Select next pay date',
                                  style: TextStyle(
                                    color:
                                        user
                                            .employmentData
                                            .nextPayDate
                                            .isNotEmpty
                                        ? Colors.black87
                                        : Colors.grey.shade600,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: AppColors.grey,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Is your pay a direct deposit?",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: user.employmentData.isDirectDeposit
                                      ? Colors.white
                                      : Colors.transparent,
                                  shape: BoxShape.circle,

                                  border: Border.all(
                                    color: user.employmentData.isDirectDeposit
                                        ? AppColors.purple
                                        : Colors.transparent,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Checkbox(
                                    value: user.employmentData.isDirectDeposit,
                                    shape: const CircleBorder(),
                                    checkColor: Colors.transparent,
                                    fillColor:
                                        WidgetStateProperty.resolveWith<Color>((
                                          Set<WidgetState> states,
                                        ) {
                                          if (states.contains(
                                            WidgetState.selected,
                                          )) {
                                            return AppColors.purple;
                                          }
                                          return Colors.white;
                                        }),
                                    side: BorderSide(
                                      color: AppColors.grey.withAlpha(100),
                                      width: 1.0,
                                    ),
                                    onChanged: (value) {
                                      ref
                                          .read(userProvider.notifier)
                                          .updateIsDirectDeposit(true);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text("Yes"),
                            ],
                          ),
                          SizedBox(width: 20.w),
                          Row(
                            children: [
                              Container(
                                width: 25.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: !user.employmentData.isDirectDeposit
                                      ? Colors.white
                                      : Colors.transparent,
                                  shape: BoxShape.circle,

                                  border: Border.all(
                                    color: !user.employmentData.isDirectDeposit
                                        ? AppColors.purple
                                        : Colors.transparent,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Checkbox(
                                    value: !user.employmentData.isDirectDeposit,
                                    shape: const CircleBorder(),
                                    checkColor: Colors.transparent,
                                    fillColor:
                                        WidgetStateProperty.resolveWith<Color>((
                                          Set<WidgetState> states,
                                        ) {
                                          if (states.contains(
                                            WidgetState.selected,
                                          )) {
                                            return AppColors.purple;
                                          }
                                          return Colors.white;
                                        }),
                                    side: BorderSide(
                                      color: AppColors.grey.withAlpha(100),
                                      width: 1.0,
                                    ),
                                    onChanged: (value) {
                                      ref
                                          .read(userProvider.notifier)
                                          .updateIsDirectDeposit(false);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text("No"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Employer address",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 90.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.grey.withAlpha(100),
                          ),
                        ),
                        child: TextFormField(
                          initialValue: user.employmentData.employerAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            ref
                                .read(userProvider.notifier)
                                .updateEmployerAddress(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Time with employer",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: AppColors.grey.withAlpha(100),
                                ),
                              ),
                              child: DropdownButtonFormField<int>(
                                initialValue:
                                    user.employmentData.yearsAtEmployer,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                                style: TextStyle(fontSize: 14.sp),
                                icon: Icon(Icons.keyboard_arrow_down, size: 20),
                                isExpanded: false,
                                menuMaxHeight: 200,
                                items: List.generate(10, (index) {
                                  final year = index + 1;
                                  return DropdownMenuItem(
                                    value: year,
                                    child: Text(
                                      year == 1 ? '1 year' : '$year years',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  );
                                }),
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(userProvider.notifier)
                                        .updateYearsAtEmployer(value);
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: AppColors.grey.withAlpha(100),
                                ),
                              ),
                              child: DropdownButtonFormField<int>(
                                initialValue:
                                    user.employmentData.monthsAtEmployer,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                                style: TextStyle(fontSize: 14.sp),
                                icon: Icon(Icons.keyboard_arrow_down, size: 20),
                                isExpanded: false,
                                menuMaxHeight: 200,
                                items: List.generate(12, (index) {
                                  final month = index + 1;
                                  return DropdownMenuItem(
                                    value: month,
                                    child: Text(
                                      month == 1 ? '1 month' : '$month months',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  );
                                }),
                                onChanged: (value) {
                                  if (value != null) {
                                    ref
                                        .read(userProvider.notifier)
                                        .updateMonthsAtEmployer(value);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: _save,
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.purple,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      "Continue",
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
      ),
    );
  }
}
