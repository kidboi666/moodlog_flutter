import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/ui/widgets/fade_in.dart';
import '../home_viewmodel.dart';

class WelcomeZone extends StatelessWidget {
  const WelcomeZone({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final nickname = context.select((HomeViewModel vm) => vm.nickname);

    debugPrint('닉네임: $nickname');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          delay: DelayMS.medium * 2,
          child: Row(
            spacing: Spacing.md,
            children: [
              Text(
                t.home_welcome(nickname ?? ''),
                style: textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        FadeIn(
          delay: DelayMS.medium * 3,
          child: Text(
            t.home_howareyou,
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
