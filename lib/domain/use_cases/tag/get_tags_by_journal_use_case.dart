import '../../../common/utils/result.dart';
import '../../entities/tag.dart';
import '../../repositories/tag_repository.dart';

class GetTagsByJournalUseCase {
  final TagRepository _tagRepository;

  GetTagsByJournalUseCase(this._tagRepository);

  Future<Result<List<Tag>>> call(int journalId) async {
    try {
      final tags = await _tagRepository.getTagsByJournalId(journalId);
      return Result.ok(tags);
    } catch (e) {
      return Result.failure(e);
    }
  }
}