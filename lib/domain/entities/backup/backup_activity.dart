import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';

part 'backup_activity.freezed.dart';
part 'backup_activity.g.dart';

@freezed
abstract class BackupActivity with _$BackupActivity {
  const factory BackupActivity({
    required int id,
    required String name,
    String? color,
    required DateTime createdAt,
  }) = _BackupActivity;

  factory BackupActivity.fromJson(Map<String, dynamic> json) =>
      _$BackupActivityFromJson(json);

  factory BackupActivity.fromActivity(Activity activity) {
    return BackupActivity(
      id: activity.id,
      name: activity.name,
      color: activity.color,
      createdAt: activity.createdAt,
    );
  }
}

extension BackupActivityX on BackupActivity {
  Activity toActivity() {
    return Activity(
      id: id,
      name: name,
      color: color,
      createdAt: createdAt,
    );
  }
}
