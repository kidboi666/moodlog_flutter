import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_journal_ai_response_request.freezed.dart';

@freezed
abstract class UpdateJournalAiResponseRequest
    with _$UpdateJournalAiResponseRequest {
  const UpdateJournalAiResponseRequest._();

  const factory UpdateJournalAiResponseRequest({
    required int id,
    required bool aiResponseEnabled,
    required String? aiResponse,
  }) = _UpdateJournalAiResponseRequest;
}
