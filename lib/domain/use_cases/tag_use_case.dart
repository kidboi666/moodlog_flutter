import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/entities/journal/tag_with_count.dart';
import 'package:moodlog/domain/repositories/tag_repository.dart';

class TagUseCase {
  final TagRepository _tagRepository;

  TagUseCase(this._tagRepository);

  Future<Result<List<TagWithCount>>> getTagsWithCount() async {
    return await _tagRepository.getTagsWithCount();
  }

  Future<Result<Tag>> addTag(String name, String? color) async {
    return await _tagRepository.addTag(name, color);
  }

  Future<Result<void>> deleteTag(int id) async {
    return await _tagRepository.deleteTag(id);
  }

  Future<Result<List<Tag>>> getAllTags() async {
    return await _tagRepository.getAllTags();
  }

  Future<Result<Tag?>> getTagById(int id) async {
    return await _tagRepository.getTagById(id);
  }

  Future<Result<List<Tag>>> getTagsByJournalId(int journalId) async {
    return await _tagRepository.getTagsByJournalId(journalId);
  }

  Future<Result<void>> updateJournalTags(
    int journalId,
    List<int> tagIds,
  ) async {
    return _tagRepository.updateJournalTags(journalId, tagIds);
  }

  Future<Result<void>> updateTag(int id, String name, String? color) async {
    return _tagRepository.updateTag(id, name, color);
  }
}
