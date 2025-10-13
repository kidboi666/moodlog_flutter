import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

class WelcomeZone extends StatelessWidget {
  const WelcomeZone({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final nickname = context.select((HomeViewModel vm) => vm.nickname);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              t.home_welcome(nickname ?? ''),
              style: TextTheme.of(context).headlineSmall,
            ),
            const SizedBox(width: Spacing.md),
          ],
        ),
        Text(
          t.home_howareyou,
          style: TextTheme.of(
            context,
          ).headlineSmall?.copyWith(color: ColorScheme.of(context).secondary),
        ),
      ],
    );
  }
}
