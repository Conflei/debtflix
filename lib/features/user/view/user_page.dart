import 'package:auto_route/auto_route.dart';
import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/router/app_router.gr.dart';
import 'package:debtflix/data/models/credit_card_account.dart';
import 'package:debtflix/data/models/credit_data.dart';
import 'package:debtflix/data/models/employment_data.dart';
import 'package:debtflix/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/user_providers.dart';

@RoutePage()
class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
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

  // Format integer to currency with commas
  String _formatCurrency(int amount) {
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formatted = amount.toString().replaceAllMapped(
      formatter,
      (Match match) => '${match[1]},',
    );
    return '\$$formatted/year';
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    // Update controller when user data changes
    if (user != null && _annualIncomeController.text.isEmpty) {
      _annualIncomeController.text = _formatCurrency(
        user.employmentData.annualIncome,
      );
    }

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("User Info"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_search_rounded),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No user data available"),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(userProvider.notifier)
                      .createUser(
                        User(
                          employmentData: EmploymentData(
                            employer: "Test Employer",
                            annualIncome: 50000,
                            employmentType: EmploymentType.fullTime,
                            jobTitle: "Software Engineer",
                            payFrequency: PayFrequency.monthly,
                            employerAddress: "123 Main St, Anytown, USA",
                            yearsAtEmployer: 5,
                            monthsAtEmployer: 3,
                            nextPayDate: DateTime.now()
                                .add(Duration(days: 15))
                                .toIso8601String(),
                            isDirectDeposit: true,
                          ),
                          creditData: CreditData(
                            creditScore: 750,
                            prevScores: [
                              MapEntry(
                                DateTime.now().subtract(Duration(days: 30)),
                                750,
                              ),
                              MapEntry(
                                DateTime.now().subtract(Duration(days: 90)),
                                740,
                              ),
                              MapEntry(
                                DateTime.now().subtract(Duration(days: 120)),
                                730,
                              ),
                            ],
                            creditCardAccounts: [
                              CreditCardAccount(
                                name: "Syncb/Amazon",
                                balance: 100,
                                limit: 1000,
                                lastReported: DateTime.now().subtract(
                                  Duration(days: 10),
                                ),
                              ),
                              CreditCardAccount(
                                name: "Wells Fargo",
                                balance: 200,
                                limit: 3000,
                                lastReported: DateTime.now().subtract(
                                  Duration(days: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                },
                child: const Text("Add User"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,

        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(userProvider.notifier).saveUser();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User data saved successfully!")),
              );
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside
          final currentUser = ref.read(userProvider);
          if (currentUser != null) {
            _annualIncomeController.text = _formatCurrency(
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
                        child: TextFormField(
                          initialValue: user.employmentData.nextPayDate,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            ref
                                .read(userProvider.notifier)
                                .updateNextPayDate(value);
                          },
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
                          Checkbox(
                            value: user.employmentData.isDirectDeposit,
                            onChanged: (value) {
                              ref
                                  .read(userProvider.notifier)
                                  .updateIsDirectDeposit(value ?? false);
                            },
                          ),
                          const Text("Direct Deposit"),
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
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    context.router.push(CreditRoute());
                  },
                  child: const Text("Navigate to Credit Page"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
