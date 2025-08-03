import '../entities/tag.dart';

abstract class TagRepository {
  Future<List<Tag>> getAllTags();
  Future<Tag?> getTagById(int id);
  Future<List<Tag>> getTagsByJournalId(int journalId);
  Future<int> addTag(String name, String? color);
  Future<void> updateTag(int id, String name, String? color);
  Future<void> deleteTag(int id);
  Future<void> addTagToJournal(int journalId, int tagId);
  Future<void> removeTagFromJournal(int journalId, int tagId);
  Future<void> updateJournalTags(int journalId, List<int> tagIds);
}