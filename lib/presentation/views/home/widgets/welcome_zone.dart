import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/home/home_viewmodel.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/shake_emoji.dart';

class WelcomeZone extends StatelessWidget {
  final HomeViewModel viewModel;

  const WelcomeZone({super.key, required this.viewModel});

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
              Text(t.home_hello, style: theme.textTheme.displayMedium),
              const ShakeEmoji(emoji: Emoji.shakeHand),
            ],
          ),
        ),
        ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return FadeIn(
              delay: const Duration(milliseconds: DelayMs.medium * 2),
              child: Text(
                t.home_welcome(viewModel.nickname!),
                style: theme.textTheme.headlineSmall,
              ),
            );
          },
        ),
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.medium * 3),
          child: Text(
            t.home_howareyou,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
