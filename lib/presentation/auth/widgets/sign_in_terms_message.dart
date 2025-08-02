import 'package:flutter/material.dart';

import '../../../common/l10n/app_localizations.dart';

class SignInTermsMessage extends StatelessWidget {
  const SignInTermsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: t.auth_terms_message(
          t.auth_terms_of_service,
          t.auth_privacy_policy,
        ),
        style: textTheme.bodySmall,
      ),
    );
  }
}
