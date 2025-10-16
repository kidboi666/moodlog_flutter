// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/services/default_data_service.dart';
import 'package:moodlog/core/services/flavor_service.dart';
import 'package:moodlog/core/utils/debug_data_seeder.dart';
import 'package:moodlog/data/data_source/local/database/database.dart';
import 'package:moodlog/domain/use_cases/check_in_use_case.dart';
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

      _log.info('Development mode: Seeding default tags...');
      final tagUseCase = context.read<TagUseCase>();
      await DefaultDataService(tagUseCase).seedDefaultTagsIfEmpty();
      _log.info('Default tags seeding completed');

      _log.info('Development mode: Seeding sample data...');
      final checkInUseCase = context.read<CheckInUseCase>();
      final journalUseCase = context.read<JournalUseCase>();
      final seeder = DebugDataSeeder(checkInUseCase, journalUseCase);
      await seeder.seedDataIfEmpty();
      _log.info('Sample data seeding completed');
    } else {
      _log.info('Production mode: Skipping all seed data');
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
