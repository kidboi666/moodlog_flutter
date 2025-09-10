class JournalTag {
  final int id;
  final int journalId;
  final int tagId;
  final DateTime createdAt;

  JournalTag({
    required this.id,
    required this.journalId,
    required this.tagId,
    required this.createdAt,
  });
}