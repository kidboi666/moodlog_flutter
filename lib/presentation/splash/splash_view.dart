import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../core/routing/routes.dart';
import '../../presentation/lock/lock_view.dart';
import '../providers/app_state_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Ensure providers are ready
    await Future.delayed(const Duration(milliseconds: 50));

    if (!mounted) return;

    final appStateProvider = context.read<AppStateProvider>();
    final bool isAppLockEnabled = appStateProvider.appState.isAppLockEnabled;

    if (isAppLockEnabled) {
      final authenticated = await _authenticate();
      if (authenticated) {
        _navigateToNextScreen();
      } else {
        context.pushReplacement(Routes.lock);
      }
    } else {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    if (!mounted) return;
    // The redirect logic in go_router will handle onboarding vs home.
    context.go(Routes.home);
  }

  Future<bool> _authenticate() async {
    final LocalAuthentication auth = context.read<LocalAuthentication>();
    try {
      return await auth.authenticate(
        localizedReason: '앱을 잠금 해제하려면 인증하세요.',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (e) {
      debugPrint('Authentication error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
