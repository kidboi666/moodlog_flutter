import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/presentation/auth/widgets/google_signin_button.dart';
import 'package:moodlog/presentation/auth/widgets/guest_signin_button.dart';
import 'package:moodlog/presentation/auth/widgets/kakao_signin_button.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../widgets/fade_in.dart';

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
      appBar: AppBar(title: Text(t.signin_title)),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          spacing: Spacing.xl * 2,
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
            FadeIn(
              delay: DelayMs.medium * 2,
              child: Text(
                t.signin_growth,
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            FadeIn(
              delay: DelayMs.medium * 3,
              child: Text(
                t.signin_login_title,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            FadeIn(
              delay: DelayMs.medium * 4,
              child: SafeArea(
                bottom: true,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GoogleSigninButton(),
                      // TODO 카카오 로그인
                      if (kDebugMode) KakaoSigninButton(),
                      if (source != SignInSource.profile) GuestSigninButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
