import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_journal_request.freezed.dart';

@freezed
abstract class AddJournalRequest with _$AddJournalRequest {
  const factory AddJournalRequest({
    String? content,
    required String moodName,
    String? imageUri,
  }) = _AddJournalRequest;
}
