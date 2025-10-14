import 'package:moodlog/domain/entities/backup/backup_data.dart';

abstract interface class LocalBackupRepository {
  Future<String> exportBackup();
  Future<void> importBackup(String filePath);
  Future<BackupData> createBackupData();
  Future<void> restoreBackupData(BackupData backupData);
}
