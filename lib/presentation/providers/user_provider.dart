import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/user/local_user.dart';
import 'package:moodlog/domain/use_cases/local_user_use_case.dart';

class UserProvider extends ChangeNotifier with AsyncStateMixin {
  final LocalUserUseCase _localUserUseCase;

  UserProvider({required LocalUserUseCase localUserUseCase})
    : _localUserUseCase = localUserUseCase {
    initialize();
  }

  LocalUser? _user;

  LocalUser? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> initialize() async {
    setLoading();
    final result = await _localUserUseCase.getUser();
    switch (result) {
      case Ok<LocalUser?>():
        _user = result.value;
        setSuccess();
        notifyListeners();
      case Error<LocalUser?>():
        debugPrint('Failed to initialize user: ${result.error}');
        setError(result.error);
    }
  }

  Future<void> refresh() async {
    final result = await _localUserUseCase.getUser();
    switch (result) {
      case Ok<LocalUser?>():
        _user = result.value;
        notifyListeners();
      case Error<LocalUser?>():
        debugPrint('Failed to refresh user: ${result.error}');
    }
  }

  Future<void> updateNickname(String newNickname) async {
    if (_user == null) return;

    final updatedUser = LocalUser(
      userId: _user!.userId,
      nickname: newNickname,
      profileImagePath: _user!.profileImagePath,
      createdAt: _user!.createdAt,
    );

    final result = await _localUserUseCase.updateUser(updatedUser);
    switch (result) {
      case Ok<void>():
        _user = updatedUser;
        notifyListeners();
      case Error<void>():
        debugPrint('Failed to update nickname: ${result.error}');
        throw result.error;
    }
  }
}
