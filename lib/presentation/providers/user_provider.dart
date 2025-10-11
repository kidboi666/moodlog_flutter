import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../core/mixins/async_state_mixin.dart';
import '../../domain/entities/user/local_user.dart';
import '../../domain/repositories/local_user_repository.dart';

class UserProvider extends ChangeNotifier with AsyncStateMixin {
  final LocalUserRepository _localUserRepository;

  UserProvider({required LocalUserRepository localUserRepository})
    : _localUserRepository = localUserRepository {
    initialize();
  }

  final Logger _log = Logger('UserProvider');
  LocalUser? _user;

  LocalUser? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> initialize() async {
    setLoading();
    try {
      _user = await _localUserRepository.getUser();
      setSuccess();
      notifyListeners();
    } catch (e) {
      _log.severe('Failed to initialize user: $e');
      setError(e);
    }
  }

  Future<void> refresh() async {
    try {
      _user = await _localUserRepository.getUser();
      notifyListeners();
    } catch (e) {
      _log.severe('Failed to refresh user: $e');
    }
  }
}
