import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

part 'backup_tag.freezed.dart';
part 'backup_tag.g.dart';

@freezed
abstract class BackupTag with _$BackupTag {
  const factory BackupTag({
    required int id,
    required String name,
    String? color,
    required DateTime createdAt,
  }) = _BackupTag;

  factory BackupTag.fromJson(Map<String, dynamic> json) =>
      _$BackupTagFromJson(json);

  factory BackupTag.fromTag(Tag tag) {
    return BackupTag(
      id: tag.id,
      name: tag.name,
      color: tag.color,
      createdAt: tag.createdAt,
    );
  }
}

extension BackupTagX on BackupTag {
  Tag toTag() {
    return Tag(
      id: id,
      name: name,
      color: color,
      createdAt: createdAt,
    );
  }
}
