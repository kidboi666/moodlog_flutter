// ignore_for_file: use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/services/default_data_service.dart';
import 'core/services/flavor_service.dart';
import 'core/services/logging_service.dart';
import 'data/repositories/analytics_repository_impl.dart';
import 'core/l10n/app_localizations.dart';
import 'domain/use_cases/tag_use_case.dart';

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
          final t = AppLocalizations.of(context)!;
          // Seed default tags if necessary (runs for all flavors)
          final tagUseCase = context.read<TagUseCase>();
          await DefaultDataService(tagUseCase).seedDefaultTagsIfEmpty(t);

          // Run dev-specific logic
          if (FlavorService.isDevelopment && onAppStartedDev != null) {
            await onAppStartedDev(context);
          }
        },
      ),
    ),
  );
}