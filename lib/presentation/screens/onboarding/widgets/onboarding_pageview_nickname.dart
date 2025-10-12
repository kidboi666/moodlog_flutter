import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/ui/widgets/fade_in.dart';
import 'package:moodlog/presentation/screens/onboarding/onboarding_view_model.dart';
import 'package:provider/provider.dart';

class OnboardingPageViewNickName extends StatefulWidget {
  final void Function() onNext;

  const OnboardingPageViewNickName({super.key, required this.onNext});

  @override
  State<OnboardingPageViewNickName> createState() =>
      _OnboardingPageViewNickNameState();
}

class _OnboardingPageViewNickNameState
    extends State<OnboardingPageViewNickName> {
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
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = context.read<OnboardingViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.xl * 2,
        children: [
          FadeIn(
            child: Text(
              t.onboarding_nickname_title,
              style: textTheme.displaySmall,
            ),
          ),
          FadeIn(
            delay: DelayMS.medium,
            child: Text(
              t.onboarding_nickname_description,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 40,
                children: [
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
                  Expanded(
                    flex: 1,
                    child: FadeIn(
                      delay: DelayMS.medium * 3,
                      child: Text(
                        t.onboarding_nickname_next,
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),

                  FadeIn(
                    delay: DelayMS.medium * 4,
                    child: SafeArea(
                      bottom: true,
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
