// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/services/default_data_service.dart';
import 'package:moodlog/core/services/flavor_service.dart';
import 'package:moodlog/core/utils/debug_data_seeder.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';
import 'package:provider/provider.dart';

class DataSeedingService {
  final BuildContext context;
  final Logger _log = Logger('DataSeedingService');

  DataSeedingService(this.context);

  Future<void> run() async {
    _log.info('DataSeedingService started');
    _log.info('Flavor: ${FlavorService.instance.flavor}');
    _log.info('isDevelopment: ${FlavorService.isDevelopment}');

    if (FlavorService.isDevelopment) {
      _log.info('Development mode: Clearing database...');
      await clearDatabaseForDevelopment();
      _log.info('Database cleared');
    }

    _log.info('Seeding default tags...');
    final tagUseCase = context.read<TagUseCase>();
    await DefaultDataService(tagUseCase).seedDefaultTagsIfEmpty(context);
    _log.info('Default tags seeding completed');

    if (FlavorService.isDevelopment) {
      _log.info('Development mode: Seeding sample journals...');
      final journalUseCase = context.read<JournalUseCase>();
      final t = AppLocalizations.of(context)!;
      final seeder = DebugDataSeeder(journalUseCase);
      await seeder.seedJournalsIfEmpty(t);
      _log.info('Sample journals seeding completed');
    } else {
      _log.info('Production mode: Skipping sample journals seeding');
    }

    _log.info('DataSeedingService completed');
  }

  Future<void> clearDatabaseForDevelopment() async {
    if (FlavorService.isDevelopment) {
      final db = context.read<MoodLogDatabase>();
      await db.clearAllTables();
    }
  }
}
