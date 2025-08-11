import '../../core/utils/result.dart';
import '../entities/tag.dart';
import '../repositories/tag_repository.dart';

class TagUseCase {
  final TagRepository _tagRepository;

  TagUseCase(this._tagRepository);

  Future<Result<int>> addTag(String name, String? color) async {
    try {
      final id = await _tagRepository.addTag(name, color);
      return Result.ok(id);
    } catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<void>> deleteTag(int id) async {
    try {
      await _tagRepository.deleteTag(id);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<List<Tag>>> getAllTags() async {
    try {
      final tags = await _tagRepository.getAllTags();
      return Result.ok(tags);
    } catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<List<Tag>>> getTagsByJournalId(int journalId) async {
    try {
      final tags = await _tagRepository.getTagsByJournalId(journalId);
      return Result.ok(tags);
    } catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<void>> updateJournalTags(int journalId, List<int> tagIds) async {
    try {
      await _tagRepository.updateJournalTags(journalId, tagIds);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<void>> updateTag(int id, String name, String? color) async {
    try {
      await _tagRepository.updateTag(id, name, color);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(e);
    }
  }
}