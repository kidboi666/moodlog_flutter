import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';
import 'package:moodlog/core/utils/flavor_config.dart';
import 'package:moodlog/firebase_options.dart' as production;
import 'package:provider/provider.dart';

import 'core/di/injection_container.dart';
import 'data/repositories/analytics_repository_impl.dart';
import 'moodlog_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: production.DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  if (Platform.isAndroid || Platform.isIOS) {
    await MobileAds.instance.initialize();
  }

  final analyticsRepo = AnalyticsRepositoryImpl();
  await analyticsRepo.initialize();

  FlavorConfig(flavor: Flavor.production, showDebugBanner: false);
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(
    MultiProvider(
      providers: createProviders(),
      child: MoodLogApp(analyticsObserver: analyticsRepo.navigatorObserver),
    ),
  );
}
