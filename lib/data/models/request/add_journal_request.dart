import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_journal_request.freezed.dart';
part 'add_journal_request.g.dart';

@freezed
abstract class AddJournalRequest with _$AddJournalRequest {
  const factory AddJournalRequest({
    String? content,
    required String moodName,
    required List<String> imageUri,
    bool? aiEnabled,
  }) = _AddJournalRequest;

  factory AddJournalRequest.fromJson(Map<String, dynamic> json) =>
      _$AddJournalRequestFromJson(json);
}
