import '../../core/utils/result.dart';

abstract class ImageRepository {
  Future<Result<String?>> pickImageFromGallery();
}
