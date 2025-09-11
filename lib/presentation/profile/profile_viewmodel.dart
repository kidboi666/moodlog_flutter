import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../core/constants/enum.dart';
import '../../core/mixins/async_state_mixin.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/use_cases/auth_use_case.dart';
import '../../domain/use_cases/pick_image_use_case.dart';
import '../providers/user_provider.dart';

class ProfileViewModel extends ChangeNotifier with AsyncStateMixin {
  final PickImageUseCase _pickImageUseCase;
  final UserProvider _userProvider;
  final AuthUseCase _authUseCase;

  ProfileViewModel({
    required PickImageUseCase pickImageUseCase,
    required UserProvider userProvider,
    required AuthUseCase authUseCase,
  }) : _pickImageUseCase = pickImageUseCase,
       _userProvider = userProvider,
       _authUseCase = authUseCase;

  final Logger _log = Logger('ProfileViewModel');
  String? _successMessage;

  String? get successMessage => _successMessage;

  void clearSuccessMessage() {
    _successMessage = null;
    setAsyncState(AsyncState.idle);
  }

  Future<Result<void>> updateDisplayName(String displayName) async {
    setAsyncState(AsyncState.loading);
    final result = await _authUseCase.updateDisplayName(displayName);
    switch (result) {
      case Ok<void>():
        _successMessage = '닉네임이 변경되었습니다.';
        setSuccess();
        return Result.ok(null);
      case Failure<void>():
        setError(result.error);
        return Result.failure(result.error);
    }
  }

  bool get isGoogleUser => _userProvider.isGoogleUser;

  User? get user => _userProvider.user;

  bool get isAnonymousUser => _userProvider.isAnonymousUser;

  Future<void> updateProfilePhoto(String photoURL) async {}

  // TODO: 프로필 이미지 기능 (파이어베이스 요금제 업그레이드 필요)
  Future<Result<void>> pickImage() async {
    setLoading();
    final result = await _pickImageUseCase.fromGallery();

    switch (result) {
      case Ok<String?>():
        final newProfilePhoto = await _updateProfilePhoto(result.value!);
        switch (newProfilePhoto) {
          case Ok<void>():
            _log.fine('Image updated successfully');
            setSuccess();
            return Result.ok(null);
          case Failure<void>():
            setError(newProfilePhoto.error);
            return Result.failure(newProfilePhoto.error);
        }
      case Failure<String?>():
        _log.warning('Failed to pick image: ${result.error}');
        return Result.failure(result.error);
    }
  }

  void signOut() {
    _authUseCase.signOut();
  }

  Future<Result<void>> _updateProfilePhoto(String photoURL) async {
    setLoading();
    final result = await _authUseCase.updateProfileImage(photoURL);
    switch (result) {
      case Ok<void>():
        return Result.ok(null);
      case Failure<void>():
        return Result.failure(result.error);
    }
  }
}
