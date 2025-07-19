import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/use_cases/image/pick_image_use_case.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../widgets/dialog/edit_display_name_dialog.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final PickImageUseCase _pickImageUseCase;

  ProfileViewModel({
    required AuthRepository authRepository,
    required PickImageUseCase pickImageUseCase,
  }) : _authRepository = authRepository,
       _pickImageUseCase = pickImageUseCase {
    _user = _authRepository.user;
    _authRepository.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  final Logger _log = Logger('ProfileViewModel');
  User? _user;
  bool _isLoading = false;
  String? _profileImage;

  User? get user => _user;

  bool get isLoading => _isLoading;

  String? get profileImage => _profileImage;

  bool get isGoogleUser {
    if (_user == null) {
      return false;
    }
    return _user!.providerData.any(
      (provider) => provider.providerId == 'google.com',
    );
  }

  bool get isAnonymousUser => _user!.isAnonymous;

  Future<void> updateDisplayName(String displayName) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authRepository.updateDisplayName(displayName);
      _user = _authRepository.user;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfilePhoto(String photoURL) async {}

  void showEditDisplayNameDialog(BuildContext context, String nickname) async {
    final result = await showDialog(
      context: context,
      builder: (_) => EditDisplayNameDialog(initialName: nickname),
    );

    if (result != null && context.mounted) {
      try {
        await updateDisplayName(result);
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('닉네임이 성공적으로 변경되었습니다')));
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('닉네임 변경에 실패했습니다: ${e.toString()}')),
          );
        }
      }
    }
  }

  Future<Result<void>> pickImage(BuildContext context) async {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('미구현 기능입니다.')));
    }
    return Result.ok(null);
    // final image = await _pickImageUseCase.pickImage();
    //
    // switch (image) {
    //   case Ok<String?>():
    //     _log.fine('Image picked successfully');
    //     _authRepository.updateProfileImage(image.value!);
    //     notifyListeners();
    //     return Result.ok(null);
    //   case Error<String?>():
    //     _log.warning('Failed to pick image: ${image.error}');
    //     notifyListeners();
    //     return Result.error(image.error);
    // }
  }
}
