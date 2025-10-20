import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/services/default_data_service.dart';
import 'package:moodlog/core/services/flavor_service.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';
import 'package:provider/provider.dart';

class DataSeedingService {
  final BuildContext context;
  final Logger _log = Logger('DataSeedingService');

  DataSeedingService(this.context);

  Future<void> run() async {
    if (!FlavorService.isDevelopment) return;

    _log.info('Seeding default tags...');
    final tagUseCase = context.read<TagUseCase>();
    await DefaultDataService(tagUseCase).seedDefaultTagsIfEmpty();
    _log.info('Default tags seeding completed');
  }
}
