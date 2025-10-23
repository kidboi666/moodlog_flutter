import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/core/constants/enum.dart';

part 'update_check_in_request.freezed.dart';

@freezed
abstract class UpdateCheckInRequest with _$UpdateCheckInRequest {
  const UpdateCheckInRequest._();

  const factory UpdateCheckInRequest({
    required int id,
    required MoodType moodType,
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
  }) = _UpdateCheckInRequest;
}
