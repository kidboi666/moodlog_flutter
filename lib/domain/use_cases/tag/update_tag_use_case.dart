import '../../../core/utils/result.dart';
import '../../repositories/tag_repository.dart';

class UpdateTagUseCase {
  final TagRepository _tagRepository;

  UpdateTagUseCase(this._tagRepository);

  Future<Result<void>> call(int id, String name, String? color) async {
    try {
      await _tagRepository.updateTag(id, name, color);
      return Result.ok(null);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
