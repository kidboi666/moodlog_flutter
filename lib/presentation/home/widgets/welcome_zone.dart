import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';
import '../../widgets/shake_emoji.dart';
import '../viewmodel/home_viewmodel.dart';

class WelcomeZone extends StatelessWidget {
  const WelcomeZone({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      spacing: Spacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          delay: DelayMs.medium * 2,
          child: Selector<HomeViewModel, String?>(
            selector: (_, viewModel) => viewModel.nickname,
            builder: (context, nickname, _) {
              return Row(
                spacing: Spacing.md,
                children: [
                  Text(
                    t.home_welcome(nickname ?? ''),
                    style: textTheme.headlineSmall,
                  ),
                  const ShakeEmoji(emoji: Emoji.shakeHand),
                ],
              );
            },
          ),
        ),
        FadeIn(
          delay: DelayMs.medium * 3,
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
