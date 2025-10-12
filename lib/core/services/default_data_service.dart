import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';

class DefaultDataService {
  final TagUseCase _tagUseCase;
  final Logger _log = Logger('DefaultDataService');

  DefaultDataService(this._tagUseCase);

  Future<void> seedDefaultTagsIfEmpty(BuildContext context) async {
    final t = AppLocalizations.of(context)!;
    final List<String> defaultTags = [
      t.default_tag_daily,
      t.default_tag_work,
      t.default_tag_health,
      t.default_tag_relationships,
      t.default_tag_hobby,
      t.default_tag_emotions,
    ];

    final tagsResult = await _tagUseCase.getAllTags();
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
          await _tagUseCase.addTag(tagName, null);
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
