import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/constants/enum.dart';

part 'create_journal_request.freezed.dart';

@freezed
abstract class CreateJournalRequest with _$CreateJournalRequest {
  const CreateJournalRequest._();

  const factory CreateJournalRequest({
    String? content,
    required MoodType moodType,
    List<String>? imageUri,
    required bool aiResponseEnabled,
    List<String>? tagNames,
    String? aiResponse,
    required DateTime createdAt,
    double? latitude,
    double? longitude,
    String? address,
    double? temperature,
    String? weatherIcon,
    String? weatherDescription,
  }) = _CreateJournalRequest;
}
