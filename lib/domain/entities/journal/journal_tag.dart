class JournalTag {
  final int id;
  final int journalId;
  final int activityId;
  final DateTime createdAt;

  JournalTag({
    required this.id,
    required this.journalId,
    required this.activityId,
    required this.createdAt,
  });
}
