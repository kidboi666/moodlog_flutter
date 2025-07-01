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
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          delay: DelayMs.medium,
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.home_hello,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const ShakeEmoji(emoji: Emoji.shakeHand),
            ],
          ),
        ),
        FadeIn(
          delay: DelayMs.medium * 2,
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              return Text(
                AppLocalizations.of(
                  context,
                )!.home_welcome(viewModel.nickname ?? ''),
                style: Theme.of(context).textTheme.headlineSmall,
              );
            },
          ),
        ),
        FadeIn(
          delay: DelayMs.medium * 3,
          child: Text(
            AppLocalizations.of(context)!.home_howareyou,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
