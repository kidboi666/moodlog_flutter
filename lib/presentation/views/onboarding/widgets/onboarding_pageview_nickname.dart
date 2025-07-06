import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/onboarding/onboarding_viewmodel.dart';
import '../../../widgets/fade_in.dart';

class OnboardingPageViewNickName extends StatefulWidget {
  final OnboardingViewModel viewModel;
  final void Function() onNext;

  const OnboardingPageViewNickName({
    super.key,
    required this.viewModel,
    required this.onNext,
  });

  @override
  State<OnboardingPageViewNickName> createState() =>
      _OnboardingPageViewNickNameState();
}

class _OnboardingPageViewNickNameState
    extends State<OnboardingPageViewNickName> {
  late TextEditingController _inputController;
  final formKey = GlobalKey<FormState>();

  String? _validateNickname(String? value) {
    if (widget.viewModel.validateNickname(value)) {
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
          delay: DelayMs.lazy,
          child: Text(
            AppLocalizations.of(context)!.onboarding_nickname_description,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),

        ListenableBuilder(
          listenable: widget.viewModel,
          builder: (_, _) => Expanded(
            flex: 1,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 40,
                children: [
                  FadeIn(
                    delay: DelayMs.lazy * 2,
                    child: TextFormField(
                      controller: _inputController,
                      onChanged: widget.viewModel.setNickname,
                      validator: _validateNickname,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(
                          context,
                        )!.onboarding_nickname_input_title,
                        hintText: AppLocalizations.of(
                          context,
                        )!.onboarding_nickname_input_hint,
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.secondaryContainer,
                        border: const UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FadeIn(
                      delay: DelayMs.lazy * 3,
                      child: Text(
                        AppLocalizations.of(context)!.onboarding_nickname_next,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  ),

                  FadeIn(
                    delay: DelayMs.lazy * 4,
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
        ),
      ],
    );
  }
}
