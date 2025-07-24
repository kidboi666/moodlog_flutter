import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'bottom_sheet/edit_display_name_dialog.dart';

class NicknameCard extends StatelessWidget {
  const NicknameCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Selector<ProfileViewModel, String>(
      selector: (context, viewModel) => viewModel.user?.displayName ?? '',
      builder: (context, nickname, _) {
        return ListTile(
          leading: Text(t.profile_nickname_title, style: textTheme.titleSmall),
          title: Row(
            children: [
              const Expanded(child: SizedBox()),
              Text(nickname, style: textTheme.bodyMedium),
            ],
          ),
          trailing: Icon(Icons.edit),
          onTap: () async {
            final newName = await showModalBottomSheet<String?>(
              isScrollControlled: true,
              context: context,
              builder: (_) {
                return EditDisplayNameBottomSheet(initialName: nickname);
              },
            );

            if (newName != null && newName.isNotEmpty && context.mounted) {
              await context.read<ProfileViewModel>().updateDisplayName(newName);
            }
          },
        );
      },
    );
  }
}
