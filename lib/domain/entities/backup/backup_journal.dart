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
    @Default('fullJournal') String entryType,
    required DateTime createdAt,
    required bool aiResponseEnabled,
    String? content,
    String? note,
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
      entryType: journal.entryType.value,
      createdAt: journal.createdAt,
      aiResponseEnabled: journal.aiResponseEnabled,
      content: journal.content,
      note: journal.note,
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
      entryType: EntryType.fromString(entryType),
      createdAt: createdAt,
      aiResponseEnabled: aiResponseEnabled,
      content: content,
      note: note,
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
