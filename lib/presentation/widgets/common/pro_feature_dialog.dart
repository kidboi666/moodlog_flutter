import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';

Future<void> showProFeatureDialog(BuildContext context) {
  final t = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('👑 ${t.proFeatureDialogTitle}'),
      content: Text(t.proFeatureDialogContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common_confirm_cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.push(Routes.purchase);
          },
          child: Text(t.proFeatureDialogUpgradeButton),
        ),
      ],
    ),
  );
}
