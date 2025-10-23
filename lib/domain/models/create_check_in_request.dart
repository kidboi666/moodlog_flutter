import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/core/constants/enum.dart';

part 'create_check_in_request.freezed.dart';

@freezed
abstract class CreateCheckInRequest with _$CreateCheckInRequest {
  const CreateCheckInRequest._();

  const factory CreateCheckInRequest({
    required MoodType moodType,
    required DateTime createdAt,
    int? sleepQuality,
    List<String>? emotionNames,
    List<String>? activityNames,
    String? memo,
    double? latitude,
    double? longitude,
    String? address,
    double? temperature,
    String? weatherIcon,
    String? weatherDescription,
  }) = _CreateCheckInRequest;
}
