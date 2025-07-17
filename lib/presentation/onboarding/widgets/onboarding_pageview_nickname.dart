import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';
import '../viewmodel/onboarding_viewmodel.dart';

class OnboardingPageViewNickName extends StatefulWidget {
  final void Function() onNext;

  const OnboardingPageViewNickName({super.key, required this.onNext});

  @override
  State<OnboardingPageViewNickName> createState() =>
      _OnboardingPageViewNickNameState();
}

class _OnboardingPageViewNickNameState
    extends State<OnboardingPageViewNickName> {
  late TextEditingController _inputController;
  final formKey = GlobalKey<FormState>();

  String? _validateNickname(String? value) {
    if (context.read<OnboardingViewModel>().validateNickname(value)) {
      return null;
    }
    return AppLocalizations.of(context)!.onboarding_nickname_input_error;
  }

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
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final onChangedNickname = context.read<OnboardingViewModel>().setNickname;

    return Column(
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
          delay: DelayMs.medium,
          child: Text(
            t.onboarding_nickname_description,
            style: textTheme.titleLarge?.copyWith(color: colorScheme.secondary),
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
                  delay: DelayMs.medium * 2,
                  child: TextFormField(
                    maxLength: 10,
                    controller: _inputController,
                    onChanged: onChangedNickname,
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
                    delay: DelayMs.medium * 3,
                    child: Text(
                      t.onboarding_nickname_next,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                  ),
                ),

                FadeIn(
                  delay: DelayMs.medium * 4,
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
    );
  }
}
