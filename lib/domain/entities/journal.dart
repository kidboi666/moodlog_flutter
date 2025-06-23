import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal.freezed.dart';
part 'journal.g.dart';

@freezed
abstract class Journal with _$Journal {
  const factory Journal({
    required int id,
    required String? content,
    required String moodName,
    required String? imageUri,
    required bool aiResponseEnabled,
    required String? aiResponse,
    required DateTime createdAt,
  }) = _Journal;

  factory Journal.fromJson(Map<String, Object?> json) =>
      _$JournalFromJson(json);
}
