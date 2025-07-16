import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';

class NicknameCard extends StatelessWidget {
  final String nickname;
  final Function updateDisplayName;
  final Function showEditDisplayNameDialog;

  const NicknameCard({
    super.key,
    required this.nickname,
    required this.updateDisplayName,
    required this.showEditDisplayNameDialog,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Text(t.profile_nickname_title, style: textTheme.titleSmall),
      title: Row(
        children: [
          const Expanded(child: SizedBox()),
          Text(nickname, style: textTheme.bodyMedium),
        ],
      ),
      trailing: Icon(Icons.edit),
      onTap: () => showEditDisplayNameDialog(context, nickname),
    );
  }
}
