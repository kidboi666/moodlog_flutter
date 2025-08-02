import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/l10n/app_localizations.dart';
import '../../viewmodel/profile_viewmodel.dart';

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
          onPressed: () {
            viewModel.signOut();
            context.pop();
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
