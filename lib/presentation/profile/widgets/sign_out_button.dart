import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'dialog/sign_out_dialog.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = context.read<ProfileViewModel>();
    return TextButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => SignOutDialog(viewModel: viewModel),
      ),
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(colorScheme.error),
      ),
      child: Text(t.profile_button_logout),
    );
  }
}
