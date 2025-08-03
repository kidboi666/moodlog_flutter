import '../../../common/utils/result.dart';
import '../../repositories/tag_repository.dart';

class AddTagUseCase {
  final TagRepository _tagRepository;

  AddTagUseCase(this._tagRepository);

  Future<Result<int>> call(String name, String? color) async {
    try {
      final id = await _tagRepository.addTag(name, color);
      return Result.ok(id);
    } catch (e) {
      return Result.failure(e);
    }
  }
}