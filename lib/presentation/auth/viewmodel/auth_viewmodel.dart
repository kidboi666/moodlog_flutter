import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../core/constants/enum.dart';
import '../../../core/mixins/async_state_mixin.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../domain/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier with AsyncStateMixin {
  final AuthRepository _authRepository;
  final AppStateProvider _appStateProvider;
  final String _nickname;
  final AiPersonality _aiPersonality;

  AuthViewModel({
    required AuthRepository authRepository,
    required AppStateProvider appStateProvider,
    required String nickname,
    required AiPersonality aiPersonality,
  }) : _authRepository = authRepository,
       _appStateProvider = appStateProvider,
       _nickname = nickname,
       _aiPersonality = aiPersonality;

  LoginType? _loginType;
  final Logger _log = Logger('AuthViewModel');

  bool get isLoadingAnonymously =>
      isLoading && _loginType == LoginType.anonymous;

  bool get isLoadingGoogle => isLoading && _loginType == LoginType.google;

  bool get isLoadingKakao => isLoading && _loginType == LoginType.kakao;

  bool get isAuthenticated => _authRepository.isAuthenticated;

  void setLoginType(LoginType loginType) {
    _loginType = loginType;
  }

  Future<void> signInAnonymously() async {
    setLoginType(LoginType.anonymous);
    setLoading();
    try {
      await _appStateProvider.updateAiPersonality(_aiPersonality);
      await _authRepository.signInAnonymously();
      await _authRepository.updateDisplayName(_nickname);
      setSuccess();
    } on FirebaseAuthException catch (e) {
      _log.warning('Failed to sign in anonymously', e);
      setError(e);
    } catch (e) {
      _log.warning('Failed to sign in anonymously', e);
      setError(e);
    }
  }

  Future<void> signInGoogle() async {
    setLoginType(LoginType.google);
    setLoading();
    try {
      await _appStateProvider.updateAiPersonality(_aiPersonality);
      await _authRepository.signInWithGoogle();
      await _authRepository.updateDisplayName(_nickname);
      setSuccess();
    } on FirebaseAuthException catch (e) {
      _log.warning('Failed to sign in with Google', e);
      setError(e);
    } catch (e) {
      _log.warning('Failed to sign in with Google', e);
      setError(e);
    }
  }
}
