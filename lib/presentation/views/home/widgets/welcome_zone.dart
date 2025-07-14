import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/home/home_viewmodel.dart';
import '../../../widgets/fade_in.dart';

class WelcomeZone extends StatelessWidget {
  const WelcomeZone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Spacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeIn(
          delay: DelayMs.medium * 2,
          child: Selector<HomeViewModel, String?>(
            selector: (_, viewModel) => viewModel.nickname,
            builder: (context, nickname, _) {
              return Text(
                AppLocalizations.of(context)!.home_welcome(nickname ?? ''),
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
