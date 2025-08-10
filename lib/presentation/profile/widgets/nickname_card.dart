import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'bottom_sheet/edit_display_name_bottom_sheet.dart';

class NicknameCard extends StatelessWidget {
  const NicknameCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final updateDisplayName = context
        .read<ProfileViewModel>()
        .updateDisplayName;
    final nickname = context.select<ProfileViewModel, String>(
      (vm) => vm.user?.displayName ?? '',
    );

    return Builder(
      builder: (context) {
        return InkWell(
          onTap: () async {
            final newName = await showModalBottomSheet<String?>(
              isScrollControlled: true,
              context: context,
              builder: (_) => EditDisplayNameBottomSheet(initialName: nickname),
            );
            if (newName != null && newName.isNotEmpty && context.mounted) {
              await updateDisplayName(newName);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
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
