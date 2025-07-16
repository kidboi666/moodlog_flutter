import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text(
              AppLocalizations.of(context)!.home_empty_box,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IconButton.filled(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Spacing.sm),
                ),
              ),
              onPressed: () {
                context.push(Routes.write);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
