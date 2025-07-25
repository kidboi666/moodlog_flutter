import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_journal_request.freezed.dart';part 'update_journal_request.g.dart';

@freezed
abstract class UpdateJournalRequest with _$UpdateJournalRequest {
  const factory UpdateJournalRequest({
    required int id,
    String? content,
    List<String>? imageUri,
    String? aiResponse,
    double? latitude,
    double? longitude,
    String? address,
  }) = _UpdateJournalRequest;

  factory UpdateJournalRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateJournalRequestFromJson(json);
}
