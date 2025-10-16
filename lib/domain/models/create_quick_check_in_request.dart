import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/core/constants/enum.dart';

part 'create_quick_check_in_request.freezed.dart';

@freezed
abstract class CreateQuickCheckInRequest with _$CreateQuickCheckInRequest {
  const CreateQuickCheckInRequest._();

  const factory CreateQuickCheckInRequest({
    required MoodType moodType,
    String? content,
    List<String>? tagNames,
    List<String>? emotionNames,
    required DateTime createdAt,
    double? latitude,
    double? longitude,
    String? address,
    double? temperature,
    String? weatherIcon,
    String? weatherDescription,
  }) = _CreateQuickCheckInRequest;
}
