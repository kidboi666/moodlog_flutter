import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/onboarding/onboarding_view_model.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:provider/provider.dart';

class OnboardingPageViewWelcome extends StatefulWidget {
  final void Function() onNext;

  const OnboardingPageViewWelcome({super.key, required this.onNext});

  @override
  State<OnboardingPageViewWelcome> createState() =>
      _OnboardingPageViewWelcomeState();
}

class _OnboardingPageViewWelcomeState extends State<OnboardingPageViewWelcome> {
  TextEditingController inputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? _validateNickname(String? value) {
    if (context.read<OnboardingViewModel>().validateNickname(value)) {
      return null;
    }
    return AppLocalizations.of(context)!.onboarding_nickname_input_error;
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = context.read<OnboardingViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: Spacing.xl * 2),
                FadeIn(
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/app-icon.png',
                      width: 96,
                      height: 96,
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.xl * 2),
                FadeIn(
                  child: Text(
                    t.onboarding_welcome_title,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: Spacing.md),
                FadeIn(
                  delay: DelayMS.medium,
                  child: Text(
                    t.onboarding_nickname_description,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: Spacing.xl),
                FadeIn(
                  delay: DelayMS.medium * 2,
                  child: TextFormField(
                    maxLength: 10,
                    controller: inputController,
                    onChanged: viewModel.setNickname,
                    validator: _validateNickname,
                    decoration: InputDecoration(
                      labelText: t.onboarding_nickname_input_title,
                      hintText: t.onboarding_nickname_input_hint,
                      filled: true,
                      fillColor: colorScheme.secondaryContainer,
                      border: const UnderlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.xl * 2),
                FadeIn(
                  delay: DelayMS.medium * 4,
                  child: SizedBox(
                    width: double.infinity,
                    child: IconButton.filled(
                      alignment: Alignment.center,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          widget.onNext();
                        }
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ).scale(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}