import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';

part 'backup_journal.freezed.dart';
part 'backup_journal.g.dart';

@freezed
abstract class BackupJournal with _$BackupJournal {
  const factory BackupJournal({
    required int id,
    required String moodType,
    required DateTime createdAt,
    required bool aiResponseEnabled,
    String? content,
    List<String>? imageUri,
    String? aiResponse,
    double? latitude,
    double? longitude,
    String? address,
    double? temperature,
    String? weatherIcon,
    String? weatherDescription,
    List<String>? tagNames,
  }) = _BackupJournal;

  factory BackupJournal.fromJson(Map<String, dynamic> json) =>
      _$BackupJournalFromJson(json);

  factory BackupJournal.fromJournal(Journal journal) {
    return BackupJournal(
      id: journal.id,
      moodType: journal.moodType.name,
      createdAt: journal.createdAt,
      aiResponseEnabled: journal.aiResponseEnabled,
      content: journal.content,
      imageUri: journal.imageUri,
      aiResponse: journal.aiResponse,
      latitude: journal.latitude,
      longitude: journal.longitude,
      address: journal.address,
      temperature: journal.temperature,
      weatherIcon: journal.weatherIcon,
      weatherDescription: journal.weatherDescription,
      tagNames: journal.tagNames,
    );
  }
}

extension BackupJournalX on BackupJournal {
  Journal toJournal() {
    return Journal(
      id: id,
      moodType: MoodType.values.byName(moodType),
      createdAt: createdAt,
      aiResponseEnabled: aiResponseEnabled,
      content: content,
      imageUri: imageUri,
      aiResponse: aiResponse,
      latitude: latitude,
      longitude: longitude,
      address: address,
      temperature: temperature,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      tagNames: tagNames,
    );
  }
}
