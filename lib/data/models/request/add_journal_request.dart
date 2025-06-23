import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_journal_request.freezed.dart';
part 'add_journal_request.g.dart';

@freezed
abstract class AddJournalRequest with _$AddJournalRequest {
  const factory AddJournalRequest({
    required String? content,
    required String moodName,
    required String? imageUri,
    required bool aiResponseEnabled,
  }) = _AddJournalRequest;

  factory AddJournalRequest.fromJson(Map<String, Object?> json) =>
      _$AddJournalRequestFromJson(json);
}
