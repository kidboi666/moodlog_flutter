import 'package:moodlog/core/services/data_seeding_service.dart';

import 'core/services/flavor_service.dart';
import 'main.dart' as app;

Future<void> main() async {
  FlavorService(flavor: Flavor.development, showDebugBanner: true);

  return app.main(
    onAppStartedDev: (context) async {
      await DataSeedingService(context).clearDatabaseForDevelopment();
    },
  );
}
