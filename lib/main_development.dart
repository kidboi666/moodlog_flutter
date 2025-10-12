import 'package:provider/provider.dart';

import 'core/services/flavor_service.dart';
import 'core/utils/debug_data_seeder.dart';
import 'domain/use_cases/journal_use_case.dart';
import 'main.dart' as app;

Future<void> main() async {
  FlavorService(flavor: Flavor.development, showDebugBanner: true);

  return app.main(
    onAppStartedDev: (context) async {
      final journalUseCase = context.read<JournalUseCase>();
      final seeder = DebugDataSeeder(journalUseCase);
      await seeder.seedJournalsIfEmpty();
    },
  );
}
