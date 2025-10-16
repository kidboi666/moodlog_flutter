import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_journal_request.freezed.dart';

@freezed
abstract class UpdateJournalRequest with _$UpdateJournalRequest {
  const UpdateJournalRequest._();

  const factory UpdateJournalRequest({
    required int id,
    required String content,
    List<String>? imageUri,
    double? latitude,
    double? longitude,
    String? address,
    double? temperature,
    String? weatherIcon,
    String? weatherDescription,
  }) = _UpdateJournalRequest;
}
