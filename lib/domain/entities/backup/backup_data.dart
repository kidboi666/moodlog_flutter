import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/domain/entities/backup/backup_journal.dart';
import 'package:moodlog/domain/entities/backup/backup_settings.dart';
import 'package:moodlog/domain/entities/backup/backup_stat.dart';
import 'package:moodlog/domain/entities/backup/backup_activity.dart';
import 'package:moodlog/domain/entities/backup/backup_user.dart';

part 'backup_data.freezed.dart';
part 'backup_data.g.dart';

@freezed
abstract class BackupData with _$BackupData {
  const factory BackupData({
    required String version,
    required DateTime backupDate,
    required BackupUser user,
    required BackupSettings settings,
    BackupStat? stat,
    required List<BackupJournal> journals,
    required List<BackupActivity> activities,
    required Map<String, String> images,
  }) = _BackupData;

  factory BackupData.fromJson(Map<String, dynamic> json) =>
      _$BackupDataFromJson(json);
}
