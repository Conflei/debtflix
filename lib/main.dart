import 'package:debtflix/core/hive/hive_setup.dart';
import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/router/app_router.dart';
import 'package:debtflix/data/models/credit_card_account.dart';
import 'package:debtflix/data/models/credit_data.dart';
import 'package:debtflix/data/models/employment_data.dart';
import 'package:debtflix/data/models/user.dart';
import 'package:debtflix/features/user/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await _initializeDefaultUser();
  runApp(ProviderScope(child: MyApp()));
}

Future<void> _initializeDefaultUser() async {
  final container = ProviderContainer();

  try {
    final userRepository = container.read(userRepositoryProvider);
    final existingUser = userRepository.getUser();

    // Only create default user if no user exists
    if (existingUser == null) {
      final defaultUser = User(
        employmentData: EmploymentData(
          employer: "Test Employer",
          annualIncome: 50000,
          employmentType: EmploymentType.fullTime,
          jobTitle: "Software Engineer",
          payFrequency: PayFrequency.monthly,
          employerAddress: "123 Main St, Anytown, USA",
          yearsAtEmployer: 5,
          monthsAtEmployer: 3,
          nextPayDate: DateTime.now().add(Duration(days: 15)).toIso8601String(),
          isDirectDeposit: true,
        ),
        creditData: CreditData(
          creditScore: 750,
          prevScores: [
            MapEntry(DateTime.now().subtract(Duration(days: 0)), 750),
            MapEntry(DateTime.now().subtract(Duration(days: 32)), 730),
            MapEntry(DateTime.now().subtract(Duration(days: 64)), 740),
            MapEntry(DateTime.now().subtract(Duration(days: 96)), 680),
            MapEntry(DateTime.now().subtract(Duration(days: 126)), 700),
            MapEntry(DateTime.now().subtract(Duration(days: 158)), 720),
            MapEntry(DateTime.now().subtract(Duration(days: 190)), 680),
            MapEntry(DateTime.now().subtract(Duration(days: 221)), 645),
            MapEntry(DateTime.now().subtract(Duration(days: 253)), 650),
            MapEntry(DateTime.now().subtract(Duration(days: 285)), 625),
            MapEntry(DateTime.now().subtract(Duration(days: 317)), 640),
            MapEntry(DateTime.now().subtract(Duration(days: 349)), 610),
          ],
          creditCardAccounts: [
            CreditCardAccount(
              name: "Syncb/Amazon",
              balance: 998,
              limit: 1000,
              lastReported: DateTime.now(),
            ),
            CreditCardAccount(
              name: "Wells Fargo",
              balance: 2500,
              limit: 3000,
              lastReported: DateTime.now().subtract(Duration(days: 20)),
            ),
            CreditCardAccount(
              name: "AVA Credit Card",
              balance: 30,
              limit: 600,
              lastReported: DateTime.now().subtract(Duration(days: 5)),
            ),
          ],
          avaCreditCard: CreditCardAccount(
            name: "AVA Credit Card",
            balance: 30,
            limit: 600,
            lastReported: DateTime.now().subtract(Duration(days: 5)),
          ),
          spendLimit: 75,
        ),
      );

      await userRepository.saveUser(defaultUser);
      print('Default user created successfully');
    }
  } catch (e) {
    print('Error initializing default user: $e');
  } finally {
    container.dispose();
  }
}

class MyApp extends StatelessWidget {
  final appRouter = AppRouter();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
          routeInformationProvider: appRouter.routeInfoProvider(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.purple,
              primary: AppColors.purple,
            ),
          ),
        );
      },
    );
  }
}
