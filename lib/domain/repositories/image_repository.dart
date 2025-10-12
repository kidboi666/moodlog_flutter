import 'package:moodlog/core/utils/result.dart';

abstract class ImageRepository {
  Future<Result<String?>> pickImageFromGallery();
}
