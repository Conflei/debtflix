import 'package:debtflix/core/hive/hive_setup.dart';
import 'package:debtflix/core/misc/app_colors.dart';
import 'package:debtflix/core/router/app_router.dart';
import 'package:debtflix/features/user/view/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(ProviderScope(child: MyApp()));
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
