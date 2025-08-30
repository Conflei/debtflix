import 'package:auto_route/auto_route.dart';
import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/router/app_router.gr.dart';
import 'package:debtflix/data/models/credit_card_account.dart';
import 'package:debtflix/data/models/credit_data.dart';
import 'package:debtflix/data/models/employment_data.dart';
import 'package:debtflix/data/models/user.dart';
import 'package:debtflix/features/user/view/widgets/user_info_display.dart';
import 'package:debtflix/features/user/view/widgets/user_info_edit.dart';
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
  bool _isEditing = false;

  void _updateEditingState(bool isEditing) {
    setState(() {
      _isEditing = isEditing;
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: const Text("Confirmation")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

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

    if (!_isEditing) {
      return UserInfoDisplay(
        onEdit: () {
          _updateEditingState(true);
        },
        onConfirm: () {
          _showConfirmationDialog();
        },
      );
    }

    return UserInfoEdit(
      onSave: () {
        _updateEditingState(false);
      },
    );
  }
}
