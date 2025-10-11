import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../core/mixins/async_state_mixin.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/user/local_user.dart';
import '../../domain/use_cases/pick_image_use_case.dart';
import '../providers/user_provider.dart';

class ProfileViewModel extends ChangeNotifier with AsyncStateMixin {
  final PickImageUseCase _pickImageUseCase;
  final UserProvider _userProvider;

  ProfileViewModel({
    required PickImageUseCase pickImageUseCase,
    required UserProvider userProvider,
  }) : _pickImageUseCase = pickImageUseCase,
       _userProvider = userProvider;

  final Logger _log = Logger('ProfileViewModel');
  String? _successMessage;

  String? get successMessage => _successMessage;

  void clearSuccessMessage() {
    _successMessage = null;
    clearState();
  }

  Future<Result<void>> updateDisplayName(String displayName) async {
    // TODO: LocalUserRepository에 닉네임 업데이트 메서드 추가 필요
    setLoading();
    _successMessage = '닉네임이 변경되었습니다.';
    setSuccess();
    return Result.ok(null);
  }

  // TODO: Phase 4에서 제거 예정 - Firebase Auth 관련 getter들
  bool get isCurrentGoogleUser => false; // 로컬 사용자는 소셜 로그인 없음

  bool get isCurrentAppleUser => false; // 로컬 사용자는 소셜 로그인 없음

  LocalUser? get user => _userProvider.user;

  bool get isAnonymousUser => false; // 로컬 사용자는 익명 로그인 없음

  Future<void> updateProfilePhoto(String photoURL) async {}

  // TODO: 프로필 이미지 기능 (파이어베이스 요금제 업그레이드 필요)
  Future<Result<void>> pickImage() async {
    // TODO: LocalUserRepository에 프로필 이미지 업데이트 메서드 추가 필요
    setLoading();
    final result = await _pickImageUseCase.fromGallery();

    switch (result) {
      case Ok<String?>():
        _log.fine('Image picked: ${result.value}');
        setSuccess();
        return Result.ok(null);
      case Error<String?>():
        _log.warning('Failed to pick image: ${result.error}');
        return Result.error(result.error);
    }
  }
}
