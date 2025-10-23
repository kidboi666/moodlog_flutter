import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/user/local_user.dart';
import 'package:moodlog/domain/repositories/local_user_repository.dart';

class LocalUserUseCase {
  final LocalUserRepository _localUserRepository;

  LocalUserUseCase({required LocalUserRepository localUserRepository})
      : _localUserRepository = localUserRepository;

  Future<Result<LocalUser?>> getUser() async {
    return await _localUserRepository.getUser();
  }

  Future<Result<LocalUser>> createUser({required String nickname}) async {
    return await _localUserRepository.createUser(nickname: nickname);
  }

  Future<Result<void>> updateUser(LocalUser user) async {
    return await _localUserRepository.updateUser(user);
  }

  Future<Result<void>> deleteAllData() async {
    return await _localUserRepository.deleteAllData();
  }
}
