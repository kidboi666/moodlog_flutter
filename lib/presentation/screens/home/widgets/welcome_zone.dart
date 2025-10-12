import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/ui/widgets/fade_in.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

class WelcomeZone extends StatelessWidget {
  const WelcomeZone({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final nickname = context.select((HomeViewModel vm) => vm.nickname);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          delay: DelayMS.medium * 2,
          child: Row(
            children: [
              Text(
                t.home_welcome(nickname ?? ''),
                style: textTheme.headlineSmall,
              ),
              const SizedBox(width: Spacing.md),
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
