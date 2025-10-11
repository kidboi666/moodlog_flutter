import 'core/utils/flavor_config.dart';
import 'main.dart' as app;

Future<void> main() async {
  FlavorConfig(flavor: Flavor.staging, showDebugBanner: false);

  return app.main();
}
