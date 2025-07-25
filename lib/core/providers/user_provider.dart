import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../domain/repositories/auth_repository.dart';
import '../mixins/async_state_mixin.dart';

class UserProvider extends ChangeNotifier with AsyncStateMixin {
  final AuthRepository _authRepository;

  UserProvider({required AuthRepository authRepository})
    : _authRepository = authRepository {
    _initializeUserStream();
  }

  final Logger _log = Logger('UserProvider');
  StreamSubscription<User?>? _userSubscription;
  User? _user;

  AuthRepository get authRepository => _authRepository;

  User? get user => _user;

  bool get isAuthenticated => _authRepository.isAuthenticated;

  bool get isAnonymousUser => _user?.isAnonymous ?? !isAuthenticated;

  bool get isGoogleUser {
    if (_user == null) {
      return false;
    }
    return _user!.providerData.any(
      (provider) => provider.providerId == 'google.com',
    );
  }

  void _initializeUserStream() {
    _userSubscription = _authRepository.userChanges.listen(
      (user) {
        _user = user;
        notifyListeners();
      },
      onError: (error) {
        _log.warning('Error in user stream: $error');
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
