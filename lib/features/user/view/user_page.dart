import 'package:debtflix/data/models/credit_data.dart';
import 'package:debtflix/data/models/employment_data.dart';
import 'package:debtflix/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_providers.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No user data available"),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(userProvider.notifier)
                      .updateUser(
                        User(
                          employmentData: EmploymentData(
                            employer: "Test Employer",
                            annualIncome: 50000,
                            employmentType: "Full-Time",
                            jobTitle: "Software Engineer",
                            payFrequency: "Monthly",
                            employerAddress: "123 Main St, Anytown, USA",
                            yearsAtEmployer: 5,
                            monthsAtEmployer: 3,
                            nextPayDate: DateTime.now().add(Duration(days: 15)),
                            isDirectDeposit: true,
                          ),
                          creditData: CreditData(creditScore: 750),
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
      appBar: AppBar(title: const Text("User Info")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Employer: ${user.employmentData.employer}"),
            Text("Yearly Income: \$${user.employmentData.annualIncome}"),
          ],
        ),
      ),
    );
  }
}
