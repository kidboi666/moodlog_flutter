import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/presentation/view_models/onboarding/onboarding_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';

class OnboardingNicknamePageView extends StatefulWidget {
  final Function onPageChange;

  const OnboardingNicknamePageView({super.key, required this.onPageChange});

  @override
  State<OnboardingNicknamePageView> createState() =>
      _OnboardingNicknamePageViewState();
}

class _OnboardingNicknamePageViewState
    extends State<OnboardingNicknamePageView> {
  late TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final viewModel = context.watch<OnboardingViewModel>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 40,
      children: [
        FadeIn(
          child: Text(
            AppLocalizations.of(context)!.onboarding_nickname_title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.lazy),
          child: Text(
            AppLocalizations.of(context)!.onboarding_nickname_description,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),

        Expanded(
          flex: 1,
          child: FadeIn(
            delay: const Duration(milliseconds: DelayMs.lazy * 2),
            child: TextFormField(
              key: formKey,
              controller: _inputController,
              onChanged: viewModel.onNicknameChanged,
              validator: (value) => viewModel.validateNickname(
                AppLocalizations.of(context)!,
                value,
              ),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(
                  context,
                )!.onboarding_nickname_input_title,
                hintText: AppLocalizations.of(
                  context,
                )!.onboarding_nickname_input_placeholder,
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondaryContainer,
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
        ),
        FadeIn(
          delay: const Duration(milliseconds: DelayMs.lazy * 3),
          child: Text(
            AppLocalizations.of(context)!.onboarding_nickname_next,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
