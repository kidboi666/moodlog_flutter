import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';

import '../../../domain/use_cases/journal_use_case.dart';

class DebugDataSeeder {
  final JournalUseCase _journalUseCase;
  final Logger _log = Logger('DebugDataSeeder');

  DebugDataSeeder(this._journalUseCase);

  String _getLocalizedTagName(String key, AppLocalizations t) {
    switch (key) {
      case 'default_tag_daily':
        return t.default_tag_daily;
      case 'default_tag_work':
        return t.default_tag_work;
      case 'default_tag_health':
        return t.default_tag_health;
      case 'default_tag_relationships':
        return t.default_tag_relationships;
      case 'default_tag_hobby':
        return t.default_tag_hobby;
      case 'default_tag_emotions':
        return t.default_tag_emotions;
      default:
        return key;
    }
  }

  Future<void> seedJournalsIfEmpty(AppLocalizations t) async {
    final journalsResult = await _journalUseCase.getJournals();
    bool isEmpty = false;
    switch (journalsResult) {
      case Ok(value: final journals):
        isEmpty = journals.isEmpty;
      case Error():
        isEmpty = true;
    }

    if (isEmpty) {
      _log.info('No journals found. Seeding sample data...');
      try {
        final jsonString =
            await rootBundle.loadString('assets/data/sample_journals.json');
        final List<dynamic> jsonList = json.decode(jsonString);

        for (final json in jsonList) {
          final tagKeys = (json['tags'] as List<dynamic>).cast<String>();
          final localizedTags =
              tagKeys.map((key) => _getLocalizedTagName(key, t)).toList();

          final request = CreateJournalRequest(
            moodType: MoodType.values.byName(json['moodType']),
            content: json['content'],
            createdAt: DateTime.parse(json['createdAt']),
            tagNames: localizedTags,
            aiResponseEnabled: false,
          );
          await _journalUseCase.addJournal(request);
        }
        _log.info('Successfully seeded ${jsonList.length} sample journals.');
      } catch (e, stackTrace) {
        _log.severe('Failed to seed sample journals', e, stackTrace);
      }
    } else {
      _log.info('Journals already exist. Skipping seeding.');
    }
  }
}
