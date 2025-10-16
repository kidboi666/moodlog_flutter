import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_journal_request.freezed.dart';

@freezed
abstract class CreateJournalRequest with _$CreateJournalRequest {
  const CreateJournalRequest._();

  const factory CreateJournalRequest({
    required String content,
    List<String>? imageUri,
    required DateTime createdAt,
    double? latitude,
    double? longitude,
    String? address,
    double? temperature,
    String? weatherIcon,
    String? weatherDescription,
  }) = _CreateJournalRequest;
}
