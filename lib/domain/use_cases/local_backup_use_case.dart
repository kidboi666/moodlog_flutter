import 'package:moodlog/domain/repositories/local_backup_repository.dart';

class LocalBackupUseCase {
  final LocalBackupRepository _localBackupRepository;

  LocalBackupUseCase({required LocalBackupRepository localBackupRepository})
      : _localBackupRepository = localBackupRepository;

  Future<String> exportBackup() async {
    return await _localBackupRepository.exportBackup();
  }

  Future<void> importBackup(String filePath) async {
    return await _localBackupRepository.importBackup(filePath);
  }
}
