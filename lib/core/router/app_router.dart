import 'package:auto_route/auto_route.dart';
import 'package:debtflix/core/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: UserRoute.page),
    AutoRoute(page: CreditRoute.page, initial: true),
  ];
}
