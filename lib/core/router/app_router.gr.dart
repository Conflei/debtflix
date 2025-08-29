// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:debtflix/features/credit/view/credit_page.dart' as _i1;
import 'package:debtflix/features/user/view/user_page.dart' as _i2;

/// generated route for
/// [_i1.CreditPage]
class CreditRoute extends _i3.PageRouteInfo<void> {
  const CreditRoute({List<_i3.PageRouteInfo>? children})
    : super(CreditRoute.name, initialChildren: children);

  static const String name = 'CreditRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.CreditPage();
    },
  );
}

/// generated route for
/// [_i2.UserPage]
class UserRoute extends _i3.PageRouteInfo<void> {
  const UserRoute({List<_i3.PageRouteInfo>? children})
    : super(UserRoute.name, initialChildren: children);

  static const String name = 'UserRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.UserPage();
    },
  );
}
