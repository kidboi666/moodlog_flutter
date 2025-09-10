import '../../core/utils/result.dart';
import '../entities/journal/tag.dart';
import '../repositories/tag_repository.dart';

class TagUseCase {
  final TagRepository _tagRepository;

  TagUseCase(this._tagRepository);

  Future<Result<int>> addTag(String name, String? color) async {
    return await _tagRepository.addTag(name, color);
  }

  Future<Result<void>> deleteTag(int id) async {
    return await _tagRepository.deleteTag(id);
  }

  Future<Result<List<Tag>>> getAllTags() async {
    return await _tagRepository.getAllTags();
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
