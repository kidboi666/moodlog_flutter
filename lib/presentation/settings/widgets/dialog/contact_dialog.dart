import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';

class ContactDialog extends StatelessWidget {
  const ContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings_information_qna_title),
      content: Text(
        '${AppLocalizations.of(context)!.common_email}: log.mind.365@gmail.com\n${AppLocalizations.of(context)!.common_phone}: 010-9383-4485',
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(AppLocalizations.of(context)!.common_confirm_ok),
        ),
      ],
    );
  }
}
