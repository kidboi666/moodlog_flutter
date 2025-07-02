import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../router/routes.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.surfaceBright,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          spacing: 28,
          children: [
            Text(
              AppLocalizations.of(context)!.home_empty_box,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IconButton.filled(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
