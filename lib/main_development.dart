import 'package:moodlog/core/services/flavor_service.dart';
import 'package:moodlog/main.dart' as app;

Future<void> main() async {
  FlavorService(flavor: Flavor.development, showDebugBanner: true);

  return app.main();
}
