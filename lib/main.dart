// ignore_for_file: use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moodlog/app.dart';
import 'package:moodlog/core/di/injection_container.dart';
import 'package:moodlog/core/services/data_seeding_service.dart';
import 'package:moodlog/core/services/flavor_service.dart';
import 'package:moodlog/core/services/logging_service.dart';
import 'package:moodlog/data/repositories/analytics_repository_impl.dart';
import 'package:provider/provider.dart';

Future<void> main({
  Future<void> Function(BuildContext context)? onAppStartedDev,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorService();
  final firebaseOptions = FlavorService.firebaseOptions;
  final logLevel = FlavorService.logLevel;

  await Firebase.initializeApp(options: firebaseOptions);
  await dotenv.load(fileName: '.env');
  await MobileAds.instance.initialize();

  final analyticsRepo = AnalyticsRepositoryImpl();
  await analyticsRepo.initialize();

  LoggingService.initialize(logLevel);

  runApp(
    MultiProvider(
      providers: createProviders(),
      child: MoodLogApp(
        analyticsObserver: analyticsRepo.navigatorObserver,
        onAppStarted: (context) async {
          await DataSeedingService(context).run();

          if (onAppStartedDev != null) {
            await onAppStartedDev(context);
          }
        },
      ),
    ),
  );
}
