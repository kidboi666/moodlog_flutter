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

  LoginMethod? _loginType;
  final Logger _log = Logger('AuthViewModel');

  bool get isLoadingAnonymously =>
      isLoading && _loginType == LoginMethod.anonymous;

  bool get isLoadingGoogle => isLoading && _loginType == LoginMethod.google;

  bool get isLoadingApple => isLoading && _loginType == LoginMethod.apple;

  bool get isAuthenticated => _authRepository.isAuthenticated;

  bool get isOnboardingCompleted =>
      !_appStateProvider.appState.shouldShowOnboarding(isAnonymousUser);

  bool get isAnonymousUser => _authRepository.isAnonymousUser;

  Future<Result<void>> signInAnonymously() async {
    setLoading();
    _loginType = LoginMethod.anonymous;
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
    _loginType = LoginMethod.apple;

    try {
      final result = await _authRepository.signInWithApple();
      switch (result) {
        case Ok<User?>():
          AnalyticsRepositoryImpl().setUserId(result.value?.uid);
          AnalyticsRepositoryImpl().setUserProperty(
            name: 'login_method',
            value: 'apple',
          );
          _log.info('Successfully signed in with Apple');

          await _appStateProvider.load();

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
    } catch (e) {
      _log.warning('Apple sign in was cancelled or failed: $e');
      clearState();
      return Result.error(Exception('Apple sign in cancelled'));
    }
  }

  Future<Result<void>> signInGoogle() async {
    setLoading();
    _loginType = LoginMethod.google;

    try {
      final result = await _authRepository.signInWithGoogle();

      switch (result) {
        case Ok<User?>():
          AnalyticsRepositoryImpl().setUserId(result.value?.uid);
          AnalyticsRepositoryImpl().setUserProperty(
            name: 'login_method',
            value: 'google',
          );

          await _appStateProvider.load();

          setSuccess();
          return Result.ok(null);

        case Error<User?>():
          _log.warning('Failed to sign in with Google', result.error);
          setError(result.error);
          return Result.error(result.error);
      }
    } catch (e) {
      _log.warning('Google sign in was cancelled or failed: $e');
      clearState();
      return Result.error(Exception('Google sign in cancelled'));
    }
  }
}
