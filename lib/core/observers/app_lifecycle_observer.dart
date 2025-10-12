import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:moodlog/presentation/lock/lock_view.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  final BuildContext context;
  final AppStateProvider appStateProvider;
  final LocalAuthentication auth;
  bool _isAuthenticating = false;

  AppLifecycleObserver({
    required this.context,
    required this.appStateProvider,
    required this.auth,
  });

  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _handleAppResumed();
    }
  }

  Future<void> _handleAppResumed() async {
    if (appStateProvider.appState.isAppLockEnabled && !_isAuthenticating) {
      _isAuthenticating = true;
      final didAuthenticate = await _authenticate();
      if (didAuthenticate) {
        // 인증 성공 시 특별한 동작 없음
      } else {
        // 인증 실패 또는 취소 시 잠금 화면 표시
        _showLockScreen();
      }
      _isAuthenticating = false;
    }
  }

  Future<bool> _authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: '앱에 접근하려면 인증이 필요합니다.',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (e) {
      // 에러 처리
      return false;
    }
  }

  void _showLockScreen() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LockScreen()),
      (route) => false,
    );
  }
}
