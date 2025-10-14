import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/domain/entities/app/stat.dart';

part 'backup_stat.freezed.dart';
part 'backup_stat.g.dart';

@freezed
abstract class BackupStat with _$BackupStat {
  const factory BackupStat({
    required int id,
    required int currentStreak,
    required int maxStreak,
    required DateTime lastActiveDate,
  }) = _BackupStat;

  factory BackupStat.fromJson(Map<String, dynamic> json) =>
      _$BackupStatFromJson(json);

  factory BackupStat.fromStat(Stat stat) {
    return BackupStat(
      id: stat.id,
      currentStreak: stat.currentStreak,
      maxStreak: stat.maxStreak,
      lastActiveDate: stat.lastActiveDate,
    );
  }
}

extension BackupStatX on BackupStat {
  Stat toStat() {
    return Stat(
      id: id,
      currentStreak: currentStreak,
      maxStreak: maxStreak,
      lastActiveDate: lastActiveDate,
    );
  }
}
