import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../core/constants/enum.dart';
import '../../core/mixins/async_state_mixin.dart';
import '../../core/utils/result.dart';
import '../../data/repositories/analytics_repository_impl.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/providers/app_state_provider.dart';

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

  bool get isAuthenticated => _authRepository.isAuthenticated;

  bool get isOnboardingCompleted =>
      _appStateProvider.appState.isOnboardingComplete;

  Future<Result<void>> signInAnonymously() async {
    setLoading();
    _loginType = LoginType.anonymous;
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

      case Error<User?>():
        _log.warning('Failed to sign in anonymously', result.error);
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<Result<void>> signInApple() async {
    setLoading();
    _loginType = LoginType.apple;
    final result = await _authRepository.signInWithApple();
    switch (result) {
      case Ok<User?>():
        AnalyticsRepositoryImpl().setUserId(result.value?.uid);
        AnalyticsRepositoryImpl().setUserProperty(
          name: 'login_method',
          value: 'apple',
        );
        _log.info('Successfully signed in with Apple');
        setSuccess();
        return Result.ok(null);

      case Error<User?>():
        _log.warning(
          'Failed to sign in with Apple ${result.error}',
          result.error,
        );
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<Result<void>> signInGoogle() async {
    setLoading();
    _loginType = LoginType.google;
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

      case Error<User?>():
        _log.warning('Failed to sign in with Google', result.error);
        setError(result.error);
        return Result.error(result.error);
    }
  }
}
