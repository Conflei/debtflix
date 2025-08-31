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
  final Function onConfirm;
  const UserPage({super.key, required this.onConfirm});

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
    print("showConfirmationDialog");
    //
    context.router.pop();
    widget.onConfirm();
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
            children: [const Text("No user data available")],
          ),
        ),
      );
    }

    if (!_isEditing) {
      return UserInfoDisplay(
        onEdit: () {
          _updateEditingState(true);
        },
        onConfirm: _showConfirmationDialog,
      );
    }

    return UserInfoEdit(
      onSave: () {
        _updateEditingState(false);
      },
    );
  }
}
