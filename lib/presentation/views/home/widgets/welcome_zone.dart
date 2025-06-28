import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/shake_emoji.dart';

class WelcomeZone extends StatelessWidget {
  const WelcomeZone({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;

    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.medium),
          child: Row(
            children: [
              Text(
                t.home_hello,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const ShakeEmoji(emoji: Emoji.shakeHand),
            ],
          ),
        ),

        // TODO: add userName
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.medium * 2),
          child: Text(
            t.home_welcome('이진욱'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.medium * 3),
          child: Text(
            t.home_howareyou,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
