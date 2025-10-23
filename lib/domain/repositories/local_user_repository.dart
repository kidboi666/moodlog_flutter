import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/user/local_user.dart';

abstract class LocalUserRepository {
  Future<Result<LocalUser?>> getUser();

  Future<Result<LocalUser>> createUser({required String nickname});

  Future<Result<void>> updateUser(LocalUser user);

  Future<Result<void>> deleteAllData();
}
