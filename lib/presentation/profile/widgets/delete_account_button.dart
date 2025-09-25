import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../profile_viewmodel.dart';
import 'dialog/delete_account_dialog.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    final viewModel = context.watch<ProfileViewModel>();

    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => DeleteAccountDialog(viewModel: viewModel),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Spacing.sm,
          children: [
            Row(
              children: [
                Text(
                  t.profile_delete_account_button,
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Icon(Icons.delete_forever_outlined, size: 20),
              ],
            ),
            Text(
              t.profile_delete_account_button_description,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
