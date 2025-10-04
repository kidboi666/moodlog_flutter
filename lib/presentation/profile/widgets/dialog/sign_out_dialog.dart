import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/routes.dart';
import '../../profile_view_model.dart';

class SignOutDialog extends StatelessWidget {
  final ProfileViewModel viewModel;

  const SignOutDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(t.profile_sign_out_title),
      content: Text(t.profile_sign_out_message),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(t.common_confirm_cancel),
        ),
        FilledButton(
          onPressed: () async {
            viewModel.signOut();
            context.pop();
            await Future.delayed(const Duration(milliseconds: 100));
            if (context.mounted) {
              context.go(Routes.signIn);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorTheme.error,
            foregroundColor: colorTheme.onError,
          ),
          child: Text(t.profile_sign_out_title),
        ),
      ],
    );
  }
}
