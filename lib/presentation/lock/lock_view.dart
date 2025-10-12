import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate(BuildContext context) async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: '앱을 잠금 해제하려면 인증하세요.',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } on PlatformException catch (e) {
      // Handle error
      debugPrint(e.toString());
      return;
    }
    if (!mounted) return;

    if (authenticated) {
      context.go(Routes.home);
    }
  }

  @override
  void initState() {
    super.initState();
    // 위젯이 빌드된 후 바로 인증 시도
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80),
            const SizedBox(height: 20),
            Text(
              '인증이 필요합니다', // TODO: 다국어 처리
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => _authenticate(context),
              icon: const Icon(Icons.refresh),
              label: const Text('재시도'), // TODO: 다국어 처리
            ),
          ],
        ),
      ),
    );
  }
}
