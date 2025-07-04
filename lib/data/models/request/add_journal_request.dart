import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants/enum.dart';

part 'add_journal_request.freezed.dart';
part 'add_journal_request.g.dart';

@freezed
abstract class AddJournalRequest with _$AddJournalRequest {
  const factory AddJournalRequest({
    String? content,
    required MoodType moodType,
    required List<String> imageUri,
    required bool aiResponseEnabled,
    String? aiResponse,
    required DateTime createdAt,
  }) = _AddJournalRequest;

  factory AddJournalRequest.fromJson(Map<String, dynamic> json) =>
      _$AddJournalRequestFromJson(json);
}
