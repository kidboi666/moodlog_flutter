import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/providers/app_state_provider.dart';

import '../../../core/constants/enum.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../domain/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier with AsyncStateMixin {
  final AuthRepository _authRepository;
  final AppStateProvider _appStateProvider;

  AuthViewModel({
    required AuthRepository authRepository,
    required AppStateProvider appStateProvider,
  }) : _authRepository = authRepository,
       _appStateProvider = appStateProvider;

  LoginType? _loginType;
  final Logger _log = Logger('AuthViewModel');

  bool get isLoadingAnonymously =>
      isLoading && _loginType == LoginType.anonymous;

  bool get isLoadingGoogle => isLoading && _loginType == LoginType.google;

  bool get isLoadingKakao => isLoading && _loginType == LoginType.kakao;

  bool get isAuthenticated => _authRepository.isAuthenticated;

  bool get isGoogleOnboardingCompleted =>
      _appStateProvider.appState.onboardedLoginTypes?.contains(
        LoginType.google.value,
      ) ??
      false;

  Future<void> signInAnonymously(BuildContext context) async {
    _loginType = LoginType.anonymous;
    setLoading();
    try {
      await _authRepository.signInAnonymously();
      setSuccess();
    } catch (e) {
      _log.warning('Failed to sign in anonymously', e);
      setError(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Anonymous sign in failed: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> signInGoogle(BuildContext context) async {
    _loginType = LoginType.google;
    setLoading();
    try {
      await _authRepository.signInWithGoogle();
      setSuccess();
    } catch (e) {
      _log.warning('Failed to sign in with Google', e);
      setError(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign in failed: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> signInKakao() async {}
}
