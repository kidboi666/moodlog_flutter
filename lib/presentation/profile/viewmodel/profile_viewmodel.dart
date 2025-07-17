import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../widgets/dialog/edit_display_name_dialog.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ProfileViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    _user = _authRepository.user;
    _authRepository.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? _user;
  bool _isLoading = false;

  User? get user => _user;

  bool get isLoading => _isLoading;

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
}
