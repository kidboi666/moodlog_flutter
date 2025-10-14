import 'dart:io';

import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/repositories/image_repository.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class PickAndSaveImageUseCase {
  final ImageRepository _imageRepository;

  PickAndSaveImageUseCase({required ImageRepository imageRepository})
    : _imageRepository = imageRepository;

  Future<Result<String?>> call() async {
    final result = await _imageRepository.pickImageFromGallery();

    switch (result) {
      case Ok<String?>():
        final pickedImagePath = result.value;
        if (pickedImagePath == null) {
          return Result.ok(null);
        }

        try {
          final appDocDir = await getApplicationDocumentsDirectory();
          final fileName = p.basename(pickedImagePath);
          final savedImagePath = '${appDocDir.path}/images/$fileName';

          final imagesDir = Directory('${appDocDir.path}/images');
          if (!await imagesDir.exists()) {
            await imagesDir.create(recursive: true);
          }

          final pickedImageFile = File(pickedImagePath);
          await pickedImageFile.copy(savedImagePath);

          return Result.ok(savedImagePath);
        } catch (e) {
          return Result.error(Exception('Failed to save image: $e'));
        }
      case Error<String?>():
        return Result.error(result.error);
    }
  }
}
