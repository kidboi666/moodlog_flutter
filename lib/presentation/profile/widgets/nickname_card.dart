import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'bottom_sheet/edit_display_name_bottom_sheet.dart';

class NicknameCard extends StatelessWidget {
  const NicknameCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Selector<ProfileViewModel, String>(
      selector: (context, viewModel) => viewModel.user?.displayName ?? '',
      builder: (context, nickname, _) {
        return InkWell(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(t.profile_nickname_title, style: textTheme.titleSmall),
                    const Spacer(),
                    Icon(Icons.edit, size: 16),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(nickname, style: textTheme.bodyMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}
