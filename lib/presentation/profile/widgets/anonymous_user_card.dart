import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';

class AnonymousUserCard extends StatelessWidget {
  const AnonymousUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(24),
          dashPattern: [5, 5],
          strokeWidth: 1,
          color: colorScheme.outlineVariant,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(t.profile_guest_mode)],
          ),
        ),
      ),
    );
  }
}
