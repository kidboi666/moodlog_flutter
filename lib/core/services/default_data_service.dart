import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/use_cases/activity_use_case.dart';

class DefaultDataService {
  final ActivityUseCase _tagUseCase;
  final Logger _log = Logger('DefaultDataService');

  DefaultDataService(this._tagUseCase);

  Future<void> seedDefaultTagsIfEmpty() async {
    const List<String> defaultTags = [
      'Daily',
      'Work',
      'Health',
      'Relationships',
      'Hobby',
      'Emotions',
    ];

    final tagsResult = await _tagUseCase.getAllActivities();
    bool isEmpty = false;
    switch (tagsResult) {
      case Ok(value: final tags):
        isEmpty = tags.isEmpty;
        break;
      case Error(error: final e):
        isEmpty = true;
        _log.warning('Could not get tags, assuming empty.', e);
        break;
    }

    if (isEmpty) {
      _log.info('No tags found. Seeding default tags...');
      try {
        for (final tagName in defaultTags) {
          await _tagUseCase.addActivity(tagName, null);
        }
        _log.info('Successfully seeded ${defaultTags.length} default tags.');
      } catch (e, stackTrace) {
        _log.severe('Failed to seed default tags', e, stackTrace);
      }
    } else {
      _log.info('Tags already exist. Skipping default tag seeding.');
    }
  }
}
