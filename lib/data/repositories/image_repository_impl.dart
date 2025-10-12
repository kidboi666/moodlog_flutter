import 'package:image_picker/image_picker.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImagePicker _imagePicker;

  ImageRepositoryImpl({ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  @override
  Future<Result<String?>> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        return Result.ok(pickedFile.path);
      }
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
