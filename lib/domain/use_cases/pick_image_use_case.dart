import '../../core/utils/result.dart';
import '../repositories/image_repository.dart';

class PickImageUseCase {
  final ImageRepository _imageRepository;

  PickImageUseCase({required ImageRepository imageRepository})
    : _imageRepository = imageRepository;

  Future<Result<String?>> fromGallery() async {
    return await _imageRepository.pickImageFromGallery();
  }
}
