import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../core/widgets/fade_in.dart';
import '../../core/widgets/shake_emoji.dart';
import '../viewmodel/home_viewmodel.dart';

class WelcomeZone extends StatelessWidget {
  const WelcomeZone({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          delay: DelayMs.medium,
          child: Row(
            spacing: Spacing.sm,
            children: [
              Text(t.home_hello, style: textTheme.displaySmall),
              const ShakeEmoji(
                emoji: Emoji.shakeHand,
                size: 36,
                repeatCount: 5,
              ),
            ],
          ),
        ),
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
