import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../core/mixins/async_state_mixin.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/repositories/auth_repository.dart';

class UserProvider extends ChangeNotifier with AsyncStateMixin {
  final AuthRepository _authRepository;

  UserProvider({required AuthRepository authRepository})
    : _authRepository = authRepository {
    _initializeUserStream();
  }

  final Logger _log = Logger('UserProvider');
  StreamSubscription<User?>? _userSubscription;
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _authRepository.isAuthenticated;

  bool get isAnonymousUser => _user?.isAnonymous == true;

  bool get isGoogleUser {
    if (_user == null) {
      return false;
    }
    return _user!.providerData.any(
      (provider) => provider.providerId == 'google.com',
    );
  }

  bool get isAppleUser {
    if (_user == null) {
      return false;
    }
    return _user!.providerData.any(
      (provider) => provider.providerId == 'apple.com',
    );
  }

  void _initializeUserStream() {
    _userSubscription = _authRepository.userChanges.listen(
      (user) {
        _user = user;
        setSuccess();
      },
      onError: (error) {
        _log.warning('Error in user stream: $error');
        setError(error);
      },
    );
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
