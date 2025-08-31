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
import 'package:flutter/material.dart' as _i4;

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
class UserRoute extends _i3.PageRouteInfo<UserRouteArgs> {
  UserRoute({
    _i4.Key? key,
    required Function onConfirm,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         UserRoute.name,
         args: UserRouteArgs(key: key, onConfirm: onConfirm),
         initialChildren: children,
       );

  static const String name = 'UserRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserRouteArgs>();
      return _i2.UserPage(key: args.key, onConfirm: args.onConfirm);
    },
  );
}

class UserRouteArgs {
  const UserRouteArgs({this.key, required this.onConfirm});

  final _i4.Key? key;

  final Function onConfirm;

  @override
  String toString() {
    return 'UserRouteArgs{key: $key, onConfirm: $onConfirm}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserRouteArgs) return false;
    return key == other.key && onConfirm == other.onConfirm;
  }

  @override
  int get hashCode => key.hashCode ^ onConfirm.hashCode;
}
