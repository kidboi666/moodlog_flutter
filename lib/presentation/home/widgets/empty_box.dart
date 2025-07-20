import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacing.xl),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Spacing.xxl),
        child: Column(
          spacing: Spacing.xxl,
          children: [
            Text(t.home_empty_box, style: textTheme.titleLarge),
            IconButton.filled(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Spacing.sm),
                ),
              ),
              onPressed: () => context.push(Routes.write),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
