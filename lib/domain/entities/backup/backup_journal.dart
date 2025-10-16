import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';

part 'backup_journal.freezed.dart';
part 'backup_journal.g.dart';

@freezed
abstract class BackupJournal with _$BackupJournal {
  const factory BackupJournal({
    required int id,
    required DateTime createdAt,
    required String content,
    List<String>? imageUri,
    double? latitude,
    double? longitude,
    String? address,
    double? temperature,
    String? weatherIcon,
    String? weatherDescription,
  }) = _BackupJournal;

  factory BackupJournal.fromJson(Map<String, dynamic> json) =>
      _$BackupJournalFromJson(json);

  factory BackupJournal.fromJournal(Journal journal) {
    return BackupJournal(
      id: journal.id,
      createdAt: journal.createdAt,
      content: journal.content,
      imageUri: journal.imageUri,
      latitude: journal.latitude,
      longitude: journal.longitude,
      address: journal.address,
      temperature: journal.temperature,
      weatherIcon: journal.weatherIcon,
      weatherDescription: journal.weatherDescription,
    );
  }
}

extension BackupJournalX on BackupJournal {
  Journal toJournal() {
    return Journal(
      id: id,
      createdAt: createdAt,
      content: content,
      imageUri: imageUri,
      latitude: latitude,
      longitude: longitude,
      address: address,
      temperature: temperature,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
    );
  }
}
