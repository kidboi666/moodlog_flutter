import '../../../common/utils/result.dart';
import '../../repositories/tag_repository.dart';

class DeleteTagUseCase {
  final TagRepository _tagRepository;

  DeleteTagUseCase(this._tagRepository);

  Future<Result<void>> call(int id) async {
    try {
      await _tagRepository.deleteTag(id);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(e);
    }
  }
}