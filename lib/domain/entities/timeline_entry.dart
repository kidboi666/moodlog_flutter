import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';

enum TimelineEntryType {
  checkIn,
  journal;

  bool get isCheckIn => this == TimelineEntryType.checkIn;
  bool get isJournal => this == TimelineEntryType.journal;
}

class TimelineEntry {
  final TimelineEntryType type;
  final int id;
  final DateTime createdAt;
  final CheckIn? checkIn;
  final Journal? journal;

  TimelineEntry({
    required this.type,
    required this.id,
    required this.createdAt,
    this.checkIn,
    this.journal,
  });

  factory TimelineEntry.fromCheckIn(CheckIn checkIn) {
    return TimelineEntry(
      type: TimelineEntryType.checkIn,
      id: checkIn.id,
      createdAt: checkIn.createdAt,
      checkIn: checkIn,
    );
  }

  factory TimelineEntry.fromJournal(Journal journal) {
    return TimelineEntry(
      type: TimelineEntryType.journal,
      id: journal.id,
      createdAt: journal.createdAt,
      journal: journal,
    );
  }
}
