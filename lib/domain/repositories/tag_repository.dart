import '../../core/utils/result.dart';
import '../entities/tag.dart';

abstract class TagRepository {
  Future<Result<List<Tag>>> getAllTags();
  Future<Result<Tag?>> getTagById(int id);
  Future<Result<List<Tag>>> getTagsByJournalId(int journalId);
  Future<Result<int>> addTag(String name, String? color);
  Future<Result<void>> updateTag(int id, String name, String? color);
  Future<Result<void>> deleteTag(int id);
  Future<Result<void>> addTagToJournal(int journalId, int tagId);
  Future<Result<void>> removeTagFromJournal(int journalId, int tagId);
  Future<Result<void>> updateJournalTags(int journalId, List<int> tagIds);
  Future<Result<bool>> isTagNameExists(String name, {int? excludeId});
  Future<Result<List<Tag>>> searchTags(String query);
}
