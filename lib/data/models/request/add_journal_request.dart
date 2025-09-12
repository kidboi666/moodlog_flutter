import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants/enum.dart';

part 'add_journal_request.freezed.dart';

@freezed
abstract class AddJournalRequest with _$AddJournalRequest {
  const factory AddJournalRequest({
    String? content,
    required MoodType moodType,
    List<String>? imageUri,
    List<String>? tagNames,
    required bool aiResponseEnabled,
    String? aiResponse,
    required DateTime createdAt,
    double? latitude,
    double? longitude,
    String? address,
    double? temperature,
    String? weatherIcon,
    String? weatherDescription,
  }) = _AddJournalRequest;
}
