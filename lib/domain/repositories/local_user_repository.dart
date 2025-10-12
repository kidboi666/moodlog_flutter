import 'package:moodlog/domain/entities/user/local_user.dart';

abstract class LocalUserRepository {
  Future<LocalUser?> getUser();

  Future<LocalUser> createUser({required String nickname});

  Future<void> updateUser(LocalUser user);

  Future<void> deleteAllData();
}
