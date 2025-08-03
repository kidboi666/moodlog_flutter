import '../../../common/utils/result.dart';
import '../../entities/tag.dart';
import '../../repositories/tag_repository.dart';

class GetAllTagsUseCase {
  final TagRepository _tagRepository;

  GetAllTagsUseCase(this._tagRepository);

  Future<Result<List<Tag>>> call() async {
    try {
      final tags = await _tagRepository.getAllTags();
      return Result.ok(tags);
    } catch (e) {
      return Result.failure(e);
    }
  }
}