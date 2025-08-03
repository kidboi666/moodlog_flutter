import '../../../common/utils/result.dart';
import '../../repositories/tag_repository.dart';

class UpdateJournalTagsUseCase {
  final TagRepository _tagRepository;

  UpdateJournalTagsUseCase(this._tagRepository);

  Future<Result<void>> call(int journalId, List<int> tagIds) async {
    try {
      await _tagRepository.updateJournalTags(journalId, tagIds);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(e);
    }
  }
}