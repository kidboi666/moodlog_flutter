import 'core/services/flavor_service.dart';
import 'main.dart' as app;

Future<void> main() async {
  FlavorService(flavor: Flavor.staging);

  return app.main();
}
