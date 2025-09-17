part of 'sign_in_screen.dart';

class _SignInScreenContent extends StatelessWidget {
  final SignInSource? source;

  const _SignInScreenContent({this.source});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Column(
            children: [
              FadeIn(
                delay: DelayMS.medium,
                child: Image.asset(
                  'assets/images/icon.png',
                  width: mediaQuery.size.width / 2,
                  height: mediaQuery.size.width / 2,
                  fit: BoxFit.contain,
                ),
              ),
              FadeIn(
                delay: DelayMS.medium * 2,
                child: Text(t.signin_title, style: textTheme.headlineMedium),
              ),
              const SizedBox(height: Spacing.md),
              FadeIn(
                delay: DelayMS.medium * 3,
                child: Text(
                  t.signin_growth,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              FadeIn(
                delay: DelayMS.medium * 4,
                child: SafeArea(
                  bottom: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GoogleSigninButton(),
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
      ),
    );
  }
}
