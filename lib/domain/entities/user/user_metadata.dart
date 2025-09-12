import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_metadata.freezed.dart';

@freezed
abstract class UserMetadata with _$UserMetadata {
  const factory UserMetadata({
    DateTime? creationTime,
    DateTime? lastSignInTime,
  }) = _UserMetadata;
}
