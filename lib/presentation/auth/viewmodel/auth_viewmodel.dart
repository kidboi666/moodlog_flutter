import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/utils/result.dart';
import '../../../data/repositories/analytics_repository_impl.dart';
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

  Future<Result<void>> signInAnonymously() async {
    _loginType = LoginType.anonymous;
    setLoading();
    final result = await _authRepository.signInAnonymously();
    switch (result) {
      case Ok<User?>():
        AnalyticsRepositoryImpl().setUserId(result.value?.uid);
        AnalyticsRepositoryImpl().setUserProperty(
          name: 'login_method',
          value: 'anonymous',
        );
        setSuccess();
        return Result.ok(null);
      case Failure<User?>():
        _log.warning('Failed to sign in anonymously', result.error);
        setError(result.error);
        return Result.failure(result.error);
    }
  }

  Future<Result<void>> signInGoogle() async {
    _loginType = LoginType.google;
    setLoading();
    final result = await _authRepository.signInWithGoogle();
    switch (result) {
      case Ok<User?>():
        AnalyticsRepositoryImpl().setUserId(result.value?.uid);
        AnalyticsRepositoryImpl().setUserProperty(
          name: 'login_method',
          value: 'google',
        );
        setSuccess();
        return Result.ok(null);
      case Failure<User?>():
        _log.warning('Failed to sign in with Google', result.error);
        setError(result.error);
        return Result.failure(result.error);
    }
  }

  Future<void> signInKakao() async {}
}
