import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/core/constants/enum.dart';

part 'update_journal_request.freezed.dart';

@freezed
abstract class UpdateJournalRequest with _$UpdateJournalRequest {
  const UpdateJournalRequest._();

  const factory UpdateJournalRequest({
    required int id,
    required MoodType moodType,
    String? content,
    List<String>? imageUri,
    required bool aiResponseEnabled,
    double? latitude,
    double? longitude,
    String? address,
    List<String>? tagNames,
  }) = _UpdateJournalRequest;
}
