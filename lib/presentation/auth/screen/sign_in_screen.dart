import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';
import '../widgets/google_signin_button.dart';
import '../widgets/guest_signin_button.dart';
import '../widgets/kakao_signin_button.dart';
import '../widgets/sign_in_terms_message.dart';

class SignInScreen extends StatelessWidget {
  final SignInSource? source;

  const SignInScreen({super.key, this.source});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final mediaquery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.signin_title, style: textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            FadeIn(
              delay: DelayMs.medium,
              child: Image.asset(
                'assets/images/icon.png',
                width: mediaquery.size.width / 2,
                height: mediaquery.size.width / 2,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: Spacing.md),
            FadeIn(
              delay: DelayMs.medium * 2,
              child: Text(
                t.signin_growth,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.outline,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            FadeIn(
              delay: DelayMs.medium * 4,
              child: SafeArea(
                bottom: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GoogleSigninButton(),
                    // TODO: 카카오 로그인 기능
                    if (kDebugMode) KakaoSigninButton(),
                    if (source != SignInSource.profile) GuestSigninButton(),
                    const SizedBox(height: Spacing.md),
                    SignInTermsMessage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
