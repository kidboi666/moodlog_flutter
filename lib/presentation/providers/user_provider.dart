import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/domain/entities/user/local_user.dart';
import 'package:moodlog/domain/repositories/local_user_repository.dart';

class UserProvider extends ChangeNotifier with AsyncStateMixin {
  final LocalUserRepository _localUserRepository;

  UserProvider({required LocalUserRepository localUserRepository})
    : _localUserRepository = localUserRepository {
    initialize();
  }

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
      debugPrint('Failed to initialize user: $e');
      setError(e);
    }
  }

  Future<void> refresh() async {
    try {
      _user = await _localUserRepository.getUser();
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to refresh user: $e');
    }
  }
}
