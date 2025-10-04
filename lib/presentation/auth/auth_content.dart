part of 'auth_view.dart';

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
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    child: Text(
                      t.signin_title,
                      style: textTheme.headlineMedium,
                    ),
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
                ],
              ),
            ),
            FadeIn(
              delay: DelayMS.medium * 4,
              child: SafeArea(
                bottom: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: Spacing.sm,
                  children: [
                    GoogleSigninButton(),
                    if (Platform.isIOS) AppleSigninButton(),
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

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (source != SignInSource.profile) return null;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
    );
  }
}
