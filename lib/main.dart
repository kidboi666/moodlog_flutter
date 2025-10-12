import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/utils/flavor_config.dart';
import 'data/repositories/analytics_repository_impl.dart';

Future<void> main({
  Future<void> Function(BuildContext context)? onAppStartedDev,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig();
  final firebaseOptions = FlavorConfig.firebaseOptions;
  final logLevel = FlavorConfig.logLevel;

  await Firebase.initializeApp(options: firebaseOptions);
  await dotenv.load(fileName: '.env');
  await MobileAds.instance.initialize();

  final analyticsRepo = AnalyticsRepositoryImpl();
  await analyticsRepo.initialize();

  Logger.root.level = logLevel;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(
    MultiProvider(
      providers: createProviders(),
      child: MoodLogApp(
        analyticsObserver: analyticsRepo.navigatorObserver,
        onAppStarted: FlavorConfig.isDevelopment ? onAppStartedDev : null,
      ),
    ),
  );
}
