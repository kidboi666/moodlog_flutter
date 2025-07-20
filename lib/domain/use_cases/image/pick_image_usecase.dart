import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';

import '../../../core/utils/result.dart';

class PickImageUseCase {
  final Logger _log = Logger('PickImageUseCase');
  final ImagePicker _picker = ImagePicker();

  Future<Result<String?>> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        _log.fine('Image picked: ${pickedFile.name}');
        return Result.ok(pickedFile.path);
      }
      return Result.ok(null);
    } catch (e) {
      _log.warning('Error picking image: $e');
      return Result.error(Exception('Failed to pick image: $e'));
    }
  }
}
